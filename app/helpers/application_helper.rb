module ApplicationHelper
  def progress(val)
    case val.to_i
    when 0..14
      css_class = 'danger'
    when 15..49
      css_class = 'warning'
    when 50..99
      css_class = 'info'
    when 100
      css_class = 'success'
    else
      css_class = ''
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
