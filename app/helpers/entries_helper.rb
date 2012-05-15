module EntriesHelper
  def table_tag (table, height, params = {})
    params[:format] ||= :json
    path = entries_path({:format => 'json', :table => table}.merge params)
    content_tag(:div, :'data-table' => raw(path), :style => "height: #{height};text-align:center;") do
      content = "<center>Loading</center>"
      content += image_tag('loading.gif', :size => '396x269', :class => 'spinner')
      raw content
    end
  end
end
