class HomeController < ApplicationController
    def index
        @projects = Project.all
        @tasks = Task.all
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
            project_id = params[:project_id]
            start_time = Time.now
            end_time = Time.now

            @task = Task.create(name: name, project_id: project_id, start_time: start_time, end_time: end_time)
            if @task.persisted?
                redirect_to root_path, notice: 'Task Created!'
            end
        else
            redirect_to root_path, alert: 'Invalid type specified.'
            end
        end
    end
