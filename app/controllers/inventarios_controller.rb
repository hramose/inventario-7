class InventariosController < ApplicationController
  # GET /inventarios
  # GET /inventarios.xml
  def index
    @inventarios = Inventario.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @inventarios }
    end
  end

  # GET /inventarios/1
  # GET /inventarios/1.xml
  def show
    @inventario = Inventario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @inventario }
    end
  end

  # GET /inventarios/new
  # GET /inventarios/new.xml
  def new
    @inventario = Inventario.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @inventario }
    end
  end

  # GET /inventarios/1/edit
  def edit
    @inventario = Inventario.find(params[:id])
  end

  # POST /inventarios
  # POST /inventarios.xml
  
  def create
    @inventario = Inventario.new(params[:inventario])
    @foto = Foto.new(:uploaded_data => params[:foto_file])
    puts "vvvvvvvvvvvvvvv"
    p params[:foto_file]
    p @foto
    puts "xxxxxxxxxxxxxxxxx"
    @service = InventarioService.new(@inventario, @foto)

    respond_to do |format|
	if @service.save
        format.html { redirect_to(@inventario, :notice => 'Inventario was successfully created.') }
        format.xml  { render :xml => @inventario, :status => :created, :location => @inventario }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @inventario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /inventarios/1
  # PUT /inventarios/1.xml
  def update
    @inventario = Inventario.find(params[:id])
    @foto = @inventario.foto
    
    @service = InventarioService.new(@inventario, @foto)
    respond_to do |format|

   if @inventario.update_attributes(params[:inventario],params[:foto_file])
        format.html { redirect_to(@inventario, :notice => 'Inventario was successfully updated.') }
        format.xml  { head :ok }
      else
	      @foto = @service.foto
        format.html { render :action => "edit" }
        format.xml  { render :xml => @inventario.errors, :status => :unprocessable_entity }
      end
    end
  end
  

  # DELETE /inventarios/1
  # DELETE /inventarios/1.xml
  def destroy
    @inventario = Inventario.find(params[:id])
    @inventario.destroy

    respond_to do |format|
      format.html { redirect_to(inventarios_url) }
      format.xml  { head :ok }
    end
  end
end
