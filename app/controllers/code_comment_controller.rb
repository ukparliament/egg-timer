class CodeCommentController < ApplicationController

  def index

    # Set meta information for the page.
    @page_title = "Calculation code comments"
    @description = "Calculation code comments."
    @crumb << { label: 'About', url: meta_list_url }
    @crumb << { label: 'Calculation code comments', url: nil }
    @section = 'calculators'
  end

  def date

    # Set meta information for the page.
    @page_title = "Calculation code comments - monkey patched date class"
    @multiline_page_title = "Calculation code comments <span class='subhead'>Monkey patched date class</span>".html_safe
    @description = "Calculation code comments for the monkey patched date class."
    @crumb << { label: 'About', url: meta_list_url }
    @crumb << { label: 'Calculation code comments', url: code_comment_list_url }
    @crumb << { label: 'Monkey patched date class', url: nil }
    @section = 'calculators'
    @include_partial = 'config_initializers_monkey_patching'
    
    render :template => 'code_comment/comment_wrapper'
  end

  def calculation_controller

    # Set meta information for the page.
    @page_title = "Calculation code comments - calculation controller"
    @multiline_page_title = "Calculation code comments <span class='subhead'>Calculation controller</span>".html_safe
    @description = "Calculation code comments for the calculation controller."
    @crumb << { label: 'About', url: meta_list_url }
    @crumb << { label: 'Calculation code comments', url: code_comment_list_url }
    @crumb << { label: 'Calculation controller', url: nil }
    @section = 'calculators'
    @include_partial = 'app_controllers_calculator_controller'
    
    render :template => 'code_comment/comment_wrapper'
  end

  def bicameral_both_houses_sitting

    # Set meta information for the page.
    @page_title = "Calculation code comments - scrutiny end date for bicameral instruments with both Houses sitting"
    @multiline_page_title = "Calculation code comments <span class='subhead'>Scrutiny end date for bicameral instruments with both Houses sitting</span>".html_safe
    @description = "Calculation code comments for the scrutiny end date of bicameral instruments with both Houses sitting."
    @crumb << { label: 'About', url: meta_list_url }
    @crumb << { label: 'Calculation code comments', url: code_comment_list_url }
    @crumb << { label: 'Scrutiny end date for bicameral instruments with both Houses sitting', url: nil }
    @section = 'calculators'
    @include_partial = 'app_lib_calculations_bicameral_both_houses_sitting'
    
    render :template => 'code_comment/comment_wrapper'
  end

  def bicameral_either_house_sitting

    # Set meta information for the page.
    @page_title = "Calculation code comments - scrutiny end date for bicameral instruments with either House sitting"
    @multiline_page_title = "Calculation code comments <span class='subhead'>Scrutiny end date for bicameral instruments with either House sitting</span>".html_safe
    @description = "Calculation code comments for the scrutiny end date of bicameral instruments with either House sitting."
    @crumb << { label: 'About', url: meta_list_url }
    @crumb << { label: 'Calculation code comments', url: code_comment_list_url }
    @crumb << { label: 'Scrutiny end date for bicameral instruments with either House sitting', url: nil }
    @section = 'calculators'
    @include_partial = 'app_lib_calculations_bicameral_si_either_house_sitting'
    
    render :template => 'code_comment/comment_wrapper'
  end

  def commons_only_sis

    # Set meta information for the page.
    @page_title = "Calculation code comments - scrutiny end date for Commons only statutory instruments"
    @multiline_page_title = "Calculation code comments <span class='subhead'>Scrutiny end date for Commons only statutory instruments</span>".html_safe
    @description = "Calculation code comments the scrutiny end date of Commons only statutory instruments."
    @crumb << { label: 'About', url: meta_list_url }
    @crumb << { label: 'Calculation code comments', url: code_comment_list_url }
    @crumb << { label: 'Scrutiny end date for Commons only statutory instruments', url: nil }
    @section = 'calculators'
    @include_partial = 'app_lib_calculations_commons_only_si'
    
    render :template => 'code_comment/comment_wrapper'
  end

  def pnsis

    # Set meta information for the page.
    @page_title = "Calculation code comments - scrutiny end date for proposed negative statutory instruments"
    @multiline_page_title = "Calculation code comments <span class='subhead'>Scrutiny end date for proposed negative statutory instruments</span>".html_safe
    @description = "Calculation code comments for the scrutiny end date of proposed negative statutory instruments."
    @crumb << { label: 'About', url: meta_list_url }
    @crumb << { label: 'Calculation code comments', url: code_comment_list_url }
    @crumb << { label: 'Scrutiny end date for proposed negative statutory instruments', url: nil }
    @section = 'calculators'
    @include_partial = 'app_lib_calculations_pnsi'
    
    render :template => 'code_comment/comment_wrapper'
  end

  def treaties

    # Set meta information for the page.
    @page_title = "Calculation code comments - scrutiny end date for treaties"
    @multiline_page_title = "Calculation code comments <span class='subhead'>Scrutiny end date for treaties</span>".html_safe
    @description = "Calculation code comments for the scrutiny end date of treaty periods A and B."
    @crumb << { label: 'About', url: meta_list_url }
    @crumb << { label: 'Calculation code comments', url: code_comment_list_url }
    @crumb << { label: 'Scrutiny end date for treaties', url: nil }
    @section = 'calculators'
    @include_partial = 'app_lib_calculations_treaty'
    
    render :template => 'code_comment/comment_wrapper'
  end

  def commons_only_sitting_days

    # Set meta information for the page.
    @page_title = "Calculation code comments - scrutiny end date for Commons only sitting days"
    @multiline_page_title = "Calculation code comments <span class='subhead'>Scrutiny end date for Commons only sitting days</span>".html_safe
    @description = "Calculation code comments for the scrutiny end date of Commons only sitting days."
    @crumb << { label: 'About', url: meta_list_url }
    @crumb << { label: 'Calculation code comments', url: code_comment_list_url }
    @crumb << { label: 'Commons only sitting days', url: nil }
    @section = 'calculators'
    @include_partial = 'app_lib_calculations_commons_only_sitting_days'
    
    render :template => 'code_comment/comment_wrapper'
  end
  
  def pnsis_reverse

    # Set meta information for the page.
    @page_title = "Calculation code comments - scrutiny start date for proposed negative statutory instruments"
    @multiline_page_title = "Calculation code comments <span class='subhead'>Scrutiny end date for proposed negative statutory instruments</span>".html_safe
    @description = "Calculation code comments for proposed negative statutory instruments."
    @crumb << { label: 'About', url: meta_list_url }
    @crumb << { label: 'Calculation code comments', url: code_comment_list_url }
    @crumb << { label: 'Proposed negative statutory instruments', url: nil }
    @section = 'calculators'
    @include_partial = 'app_lib_calculations_pnsi'
    
    render :template => 'code_comment/comment_wrapper'
  end
end
