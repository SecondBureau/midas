module MenuHelper

  def link_to_switch_locale( locale, trigger=false )
    uparams = params.dup
    uparams[:locale] = locale
    options = {:title => locale}
    options = options.merge({:class => "dropdown-toggle locale-switcher", :"data-toggle" => "dropdown", :"data-target" => "#" }) if trigger
    link_to "#{image_tag("icons/flags/#{locale}.png")}#{trigger ? '<b class=\'caret\'></b>' : ''}".html_safe, refinery.url_for(uparams.merge(:only_path => true )), options
  end

  def bootstrap_menu_branch_css(local_assigns)
    options = local_assigns.dup
          options.update(:sibling_count => options[:menu_branch].shown_siblings.length) unless options[:sibling_count]

          css = []
          css << Refinery::Core.menu_css[:selected] if selected_page_or_descendant_page_selected?(local_assigns[:menu_branch]) unless Refinery::Core.menu_css[:selected].nil?
          css << Refinery::Core.menu_css[:first] if options[:menu_branch_counter] == 0 unless Refinery::Core.menu_css[:first].nil?
          css << Refinery::Core.menu_css[:last] if options[:menu_branch_counter] == options[:sibling_count] unless Refinery::Core.menu_css[:last].nil?
          css
  end

end
