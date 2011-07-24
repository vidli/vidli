class Admin::VideosController < Admin::AdminController
  filter_access_to :all, :context => :admin_videos

  def index
    @videos = Video.all.paginate :per_page => 10, :page => params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @videos }
    end
  end

  # GET /videos/1
  # GET /videos/1.xml
  def show
    @video = Video.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @video }
    end
  end

  # GET /videos/new
  # GET /videos/new.xml
  def new
    @video = Video.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @video }
    end
  end

  # GET /videos/1/edit
  def edit
    @video = Video.find(params[:id])
  end

  # POST /videos
  # POST /videos.xml
  def create
    @video = Video.new(params[:video])

    respond_to do |format|
      if @video.save
        format.html { redirect_to(edit_admin_video_path(@video), :notice => 'Video was successfully created.') }
        format.xml  { render :xml => @video, :status => :created, :location => @video }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /videos/1
  # PUT /videos/1.xml
  def update
    @video = Video.find(params[:id])

    respond_to do |format|
      if @video.update_attributes(params[:video])
        format.html { redirect_to([:admin, @video], :notice => 'Video was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.xml
  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    respond_to do |format|
      format.html { redirect_to(admin_videos_url) }
      format.xml  { head :ok }
    end
  end
  
  def update_s3_path
    @video = Video.find(params[:id])
    @video.update_attribute(:s3_path, params[:file_name])

    respond_to do |format|
      format.html { redirect_to(admin_videos_url) }
      format.json { render :json => {:status => 'success'} }
    end
  end
  
  def delete_s3_asset
    @video = Video.find(params[:id])
    
    AWS::S3::Base.establish_connection!(
        :access_key_id     => S3SwfUpload::S3Config.access_key_id, 
        :secret_access_key => S3SwfUpload::S3Config.secret_access_key
      )
    AWS::S3::S3Object.delete @video.s3_path, S3SwfUpload::S3Config.bucket if AWS::S3::S3Object.exists? @video.s3_path, S3SwfUpload::S3Config.bucket
    @video.update_attribute(:s3_path, nil)

    respond_to do |format|
      format.html { redirect_to(edit_admin_video_url(@video)) }
    end
  end
  
  def download
    @video = Video.find(params[:id])
    
    AWS::S3::Base.establish_connection!(
      :access_key_id     => S3SwfUpload::S3Config.access_key_id, 
      :secret_access_key => S3SwfUpload::S3Config.secret_access_key
    )

    redirect_to AWS::S3::S3Object.url_for(@video.s3_path, S3SwfUpload::S3Config.bucket, :expires_in => VidliConfig.s3_expires_in, :use_ssl => false)
  end
  
  def stream
    @video = Video.find(params[:id])
    
    AWS::S3::Base.establish_connection!(
      :access_key_id     => S3SwfUpload::S3Config.access_key_id, 
      :secret_access_key => S3SwfUpload::S3Config.secret_access_key
    )

    redirect_to AWS::S3::S3Object.url_for(@video.s3_path, S3SwfUpload::S3Config.bucket, :expires_in => VidliConfig.s3_expires_in, :use_ssl => false)
  end
end