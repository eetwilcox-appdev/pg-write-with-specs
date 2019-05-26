class PicturesController < ApplicationController
  def recent
    @photos = Photo.all.order({ :created_at => :desc }).limit(25)

    render("pic_templates/time_list.html.erb")
  end

  def most_liked
    @photos = Photo.all.order({ :likes_count => :desc }).limit(25)

    render("pic_templates/liked_list.html.erb")
  end

  def show_details
    photo_id = params.fetch("some_id")

    @pic = Photo.where({ :id => photo_id }).at(0)

    render("pic_templates/details.html.erb")
  end
  
  def byyyeee
    # step 1: delete the photo
    pic_id = params.fetch("id_to_delete")
    photo = Photo.where({ :id => pic_id }).at(0)
    photo.destroy
    
    # step 2: redirect to popular page
    redirect_to("/popular")
  end
  
  def blank_form
    render("pic_templates/new_photo_form.html.erb")
  end
  
  def save_new_row
    new_photo = Photo.new
    new_photo.caption = params.fetch("pic_caption")
    new_photo.image = params.fetch("pic_image")
    new_photo.owner_id = params.fetch("poster_id")
    new_photo.save
    
    redirect_to("/recent")
  end
  
  def filled_form
    pic_id = params.fetch("id_to_prefill")
    @picture = Photo.where({ :id => pic_id }).at(0)
    
    render("pic_templates/edit_photo.html.erb")
  end
  
  def save_old_row
    old_photo = Photo.where({ :id => :id_to_update })
    old_photo.caption = params.fetch("pic_caption")
    old_photo.image = params.fetch("pic_image")
    old_photo.save
    
    redirect_to("/photos/" + params.fetch("id_to_update"))
  end
  
end
