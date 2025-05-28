require 'fileutils'
require 'redcarpet'
require 'pathname'
require 'time'
require 'cgi' 

# use app layout

class Documenter
  def initialize(output_dir = "/public/egg-timer/docs/", github_repo = "ukparliament/egg-timer")
    @source_dirs = [
      Pathname.new("./app/lib/calculations/").realpath
    ]
    
    # Additional specific files to include
    @additional_files = [
      "./app/controllers/calculator_controller.rb",
      "./config/initializers/monkey_patching.rb"
    ]
    
    @output_dir = Pathname.new(output_dir).realpath
    @github_repo = github_repo
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, with_toc_data: true)
    @files = [] # Will store [file_path, relative_path, source_dir]
  end

  def generate_documentation
    # Check if any source directory is the same as output directory
    @source_dirs.each do |src_dir|
      if src_dir == @output_dir
        puts "Error: Source directory and output directory are the same."
        puts "This could overwrite your source files. Please specify a different output directory."
        exit 1
      end
    end

    FileUtils.mkdir_p(@output_dir)
    collect_files
    process_files
  end

  private
  
  def collect_files
    # First collect files from source directories
    @source_dirs.each do |source_dir|
      Dir.glob(File.join(source_dir, '**', '*.rb')).each do |file|
        puts file
        relative_path = Pathname.new(file).relative_path_from(source_dir)
        @files << [file, relative_path, source_dir]
      end
    end
    
    # Then collect specific additional files
    @additional_files.each do |file_path|
      if File.exist?(file_path)
        absolute_path = Pathname.new(file_path).realpath
        # For additional files, use their full path as a base for relative pathing
        # Strip the leading "./" if present
        relative_path = Pathname.new(file_path.sub(/^\.\//, ''))
        puts file_path
        @files << [absolute_path, relative_path, nil]
      else
        puts "Warning: Additional file not found: #{file_path}"
      end
    end
    
    # Sort files by their relative paths
    @files.sort_by! { |_, relative_path, _| relative_path.to_s }
  end

  def process_files
    @files.each do |file_path, relative_path, source_dir|
      # For additional files, we already have the absolute path
      output_file = @output_dir.join(relative_path.sub_ext('.html'))
      FileUtils.mkdir_p(output_file.dirname)
      content = process_file(file_path, relative_path)
      html_content = wrap_html(content, relative_path.to_s)
      File.write(output_file, html_content)
    end
  end

  def process_file(file, relative_path)
    content = []
    File.readlines(file).each_with_index do |line, index|
      next if line.strip.empty? # Ignore blank lines
      if line.strip.start_with?('#')
        content << process_comment(line)
      else
        content << process_code(line, index + 1, relative_path)
      end
    end
    content.join("\n")
  end

  def process_comment(line)
    cleaned_line = line.strip.sub(/^#/, '')
    @markdown.render(cleaned_line.strip)
  end

  def process_code(line, line_number, relative_path)
    # Use HTML entities to escape special characters
    code_html = CGI.escapeHTML(line.chomp)
    line_link = generate_line_link(relative_path, line_number)
    "<pre><code><span class='line-number'>#{line_link}</span>#{code_html}</code></pre>"
  end

  def generate_line_link(relative_path, line_number)
    # The relative path is now the path from the workspace root
    href = "https://github.com/#{@github_repo}/blob/main/#{relative_path}#L#{line_number}"
    "<a href='#{href}' title='View on GitHub'>#{line_number}</a>"
  end

  def wrap_html(content, title)
    timestamp = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    
    <<~HTML
      <h1>#{title}</h1>
      
      <p>
        View full file: 
        <a href="https://github.com/#{@github_repo}/blob/main/#{title}" target="_blank">
          on GitHub
        </a>
      </p>
      
      <div class="content">
        #{content}
      </div>
      
      <p class="text-muted">Generated on: #{timestamp}</p>
    HTML
  end
end

namespace :docs do
  desc "Generate documentation from Ruby source files"
  task :new do |t, args|

    args.with_defaults(         
      output: ENV['OUTPUT_DIR'] || File.join(Dir.pwd, 'public/egg-timer/docs'),
      github_repo: ENV['GITHUB_REPO']
    )

    puts "Generating documentation..."
    puts "Source directories and files:"
    puts "- app/lib/calculations/ (directory)"
    puts "- app/controllers/calculator_controller.rb (file)"
    puts "- config/initializers/monkey_patching.rb (file)" 
    puts "Output directory: #{args.output}"
    puts "GitHub repository: #{args.github_repo}" if args.github_repo
    
    begin
      documenter = Documenter.new(args.output, args.github_repo)
      documenter.generate_documentation
      puts "Documentation successfully generated in #{args.output}"
    rescue Errno::ENOENT => e
      puts "Error: #{e.message}"
      exit 1
    end
  end
  
end
