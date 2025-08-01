require 'fileutils'
require 'redcarpet'
require 'pathname'
require 'time'
require 'cgi'
require 'erb'

# use app layout

class Documenter
  def initialize(output_dir = "/app/views/code_comment/comments/", github_repo = "ukparliament/egg-timer")
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
    project_root = Pathname.new(Dir.pwd)

    # First collect files from source directories
    @source_dirs.each do |source_dir|
      Dir.glob(File.join(source_dir, '**', '*.rb')).each do |file|
        absolute_path = Pathname.new(file).realpath
        # Ensure the relative path is from the project root for correct GitHub links
        relative_path = absolute_path.relative_path_from(project_root)
        puts "Found file: #{relative_path}"
        @files << [absolute_path, relative_path, source_dir]
      end
    end
    
    # Then collect specific additional files
    @additional_files.each do |file_path|
      if File.exist?(file_path)
        absolute_path = Pathname.new(file_path).realpath
        # Ensure the relative path is from the project root
        relative_path = absolute_path.relative_path_from(project_root)
        puts "Found file: #{relative_path}"
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
      flat_filename = '_' + relative_path.sub_ext('.html.erb').to_s.gsub('/', '_')
      
      output_file = @output_dir.join(flat_filename)
      
      content = process_file(file_path, relative_path)
      # The title and links will use the full relative_path
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
    "<pre><code>#{line_link}#{code_html}</code></pre>"
  end

  def generate_line_link(relative_path, line_number)
    # The relative path is now the full path from the project root
    href = "https://github.com/#{@github_repo}/blob/main/#{relative_path}#L#{line_number}"
    "<a href='#{href}' title='View on GitHub'>#{line_number}</a> "
  end

  def wrap_html(content, title)
  content_without_h1 = content.gsub(/<h1>.*?<\/h1>/, '')
    
    ERB.new(<<~ERB).result(binding)
      <p>
            On GitHub: 
            <a href="https://github.com/<%= @github_repo %>/blob/main/<%= title %>">
              <%= title %>
            </a>
          </p>
          <%= content_without_h1 %>

    ERB
  end
end

namespace :docs do
  desc "Generate documentation from Ruby source files"
  task :new do |t, args|

    args.with_defaults(         
      output: File.join(Dir.pwd, 'app/views/code_comment/comments'),
      github_repo: 'ukparliament/egg-timer'
    )

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