module ApplicationHelper
  def progress(val)
    if val == 100
      css_class = 'success'
    elsif val == 0
      css_class = 'warning'
    else
      css_class = 'info'
    end
    return content_tag(:div, 'class' => 'progress') {
      content_tag(:div, '',
                  'class' => "progress-bar progress-bar-#{css_class}",
                  role: "progressbar",
                  'aria-valuenow' => val.to_s,
                  'aria-valuemin' => "0",
                  'aria-valuemax' => "100",
                  style: "width: #{val}%")
    }
  end
end
