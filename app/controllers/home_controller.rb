 class HomeController < ApplicationController
    def index
        @projects = Project.all
        @favorite_project = @projects.where(favorite: true).first
        
        # Determine which project to load tasks from
        if params[:project_id].present?
            @current_project = @projects.find_by(id: params[:project_id])
        elsif @favorite_project
            @current_project = @favorite_project
        else
            @current_project = @projects.first
        end
        
        # Load tasks for the current project
        @tasks = @current_project ? Task.where(project_id: @current_project.id) : []
    end

    def select_project
        project_id = params[:project_id]
        redirect_to root_path(project_id: project_id)
    end

    def create_item
        name = params[:name]
        type = params[:type]
        
        if type == "projects"
            @project = Project.create(name: name)

            if @project.persisted?
                redirect_to root_path, notice: 'Project created!'
            else 
                redirect_to root_path, alert: 'Error creating project.'
            end
        elsif type == "tasks"
            # Use the current project or favorite project for new tasks
            current_project_id = params[:current_project_id] || Project.where(favorite: true).first&.id
            if current_project_id.nil?
                redirect_to root_path, alert: 'No project selected for task creation.'
                return
            end
            
            start_time = Time.now

            @task = Task.create(name: name, project_id: current_project_id, start_time: start_time)
            if @task.persisted?
                redirect_to root_path(project_id: current_project_id), notice: 'Task Created!'
            else
                redirect_to root_path, alert: 'Error creating task.'
            end
        else
            redirect_to root_path, alert: 'Invalid type specified.'
            end
        end

        def edit_task
            @task = Task.find(params[:id])
            
            if @task.update(end_time: Time.now)
                # Redirect back to the same project
                redirect_to root_path(project_id: @task.project_id), notice: 'Task updated!'
            else
                redirect_to root_path, alert: 'Error completing task.'
            end
            
        end

end
