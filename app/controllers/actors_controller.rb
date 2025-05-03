class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def insert_actor

    new_actor = Actor.new
    new_actor.image = params.fetch("query_image")
    new_actor.name = params.fetch("query_name")
    new_actor.dob = params.fetch("query_dob")
    new_actor.bio = params.fetch("query_bio")

    new_actor.save
  
    redirect_to("/actors")

  end

  def delete_actor

    existing_id = params.fetch("path_id")

    matching_records = Actor.where({ :id => existing_id })
    the_actor = matching_records.at(0)

    the_actor.destroy

    redirect_to("/actors")

  end

  def modify_actor

    existing_id = params.fetch("path_id")

    existing_actor = Actor.find(existing_id)
    existing_actor.image = params.fetch("query_image")
    existing_actor.name = params.fetch("query_name")
    existing_actor.dob = params.fetch("query_dob")
    existing_actor.bio = params.fetch("query_bio")

    existing_actor.save

    redirect_to("/actors/#{existing_id}")

  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end
end
