class HomeController < ApplicationController
    def index
        @projects = Project.all
        @favorite_project = @projects.where(favorite: true)
        @tasks = Task.where(project_id: @favorite_project.first.id) if @favorite_project.exists?
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
            project_id = Project.where(favorite: true).first.id
            start_time = Time.now
            end_time = Time.now

            @task = Task.create(name: name, project_id: project_id, start_time: start_time)
            if @task.persisted?
                redirect_to root_path, notice: 'Task Created!'
            end
        else
            redirect_to root_path, alert: 'Invalid type specified.'
            end
        end

        def edit_task
            @task = Task.find(params[:id])
            
            if @task.update(end_time: Time.now)
                redirect_to root_path, notice: 'Task updated!'
            else
                redirect_to root_path, alert: 'Error completing task.'
            end
            
        end

end
