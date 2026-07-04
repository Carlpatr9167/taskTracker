module ApplicationHelper
  def format_task_time(time)
    return "—" if time.blank?

    time.strftime("%-I:%M %p")
  end

  def task_status(task)
    task.end_time.present? ? "Complete" : "In progress"
  end

  def task_status_class(task)
    task.end_time.present? ? "status-badge status-badge--complete" : "status-badge status-badge--active"
  end

  def project_options_for_select(projects)
    projects.map do |project|
      label = project.favorite? ? "#{project.name} ★" : project.name
      [ label, project.id ]
    end
  end
end
