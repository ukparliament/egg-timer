require 'fileutils'
require 'redcarpet'
require 'pathname'
require 'time'
require 'cgi' 

class Documenter
  def initialize(output_dir = "/public/egg-timer/docs/", github_repo = "ukparliament/egg-timer")
    @source_dir = Pathname.new("./app/lib/calculations/").realpath
    # /app/controllers/calculator_controller.rb
    # /config/initializers/monkey_patching.rb
    @output_dir = Pathname.new(output_dir).realpath
    @github_repo = github_repo
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, with_toc_data: true)
    @files = []
  end

  def generate_documentation
    if @source_dir == @output_dir
      puts "Error: Source directory and output directory are the same."
      puts "This could overwrite your source files. Please specify a different output directory."
      exit 1
    end

    FileUtils.mkdir_p(@output_dir)
    collect_files
    process_files
  end

  private
  
  def collect_files
    # First collect all files as Pathname objects
    Dir.glob(File.join(@source_dir, '**', '*.rb')).each do |file|
      puts file
      relative_path = Pathname.new(file).relative_path_from(@source_dir)
      @files << relative_path
    end
    @files.sort! # Sort files alphabetically
  end

  def process_files
    @files.each do |relative_path|
      file = @source_dir.join(relative_path)
      output_file = @output_dir.join(relative_path.sub_ext('.html'))
      FileUtils.mkdir_p(output_file.dirname)
      content = process_file(file, relative_path)
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
     
#       html_out << "<code title='Line #{line_num + 1}, #{with_path}'><pre><a name='#{line_num + 1}'  class='githubline' href='https://github.com/ukparliament/egg-timer/blob/main/#{with_path}#L#{line_num + 1}'> #{line_num + 1}</a> " << line << '</pre></code>'
      href = 

      "https://github.com/ukparliament/egg-timer/blob/main/app/lib/calculations/#{relative_path}#L#{line_number}"
      "<a href='#{href}' title='View on GitHub'>#{line_number}</a>"

  end

  def wrap_html(content, title)
    timestamp = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    

    @files.each do |file|
      html_file = file.to_s.sub(/\.rb$/, '.html')
    end
    

    
    <<~HTML
      
                        #{title}
                     
                     
                      
                          View full file: 
                          <a href="https://github.com/#{@github_repo}/blob/main/app/lib/calculations/#{title}" target="_blank">
                            on GitHub
                          </a>
              
                      
                      
                        #{content}
                      
                      
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
    puts "Source directory: /app/lib/calculations/ (fixed)"
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
