class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.all
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

# base URL of this application
BASE_URL = "http://olucube-phone-directory-rails.herokuapp.com/employees"
# GET /employees/directory
  def directory
    @post_to = BASE_URL + '/menu'
    render :action => "directory.xml.builder", :layout => false
    return
  end
# POST /employees/menu
  def menu
    @post_to = BASE_URL + '/extension'
    # If 1 is entered, do extension entry
      if params['Digits'] == '1'
        render :action => "extension.xml.builder", :layout => false
        return
      end
   # If 2 is entered, list all employees
      if params['Digits'] == '2'
        @employees = Employee.all
        render :action => "list.xml.builder", :layout => false
        return
      end
  end


# POST /employees/extension
  def extension
   # Get employee with extension entered from database
    @employees = Employee.where("extension = ?", params['Digits']).limit(1)

    if @employees.count == 1
     # Connect to phone number entered
      @employee = @employees[0]
      render :action => "call.xml.builder", :layout => false
    else
     # No entry found for extension entered
      @entry = params['Digits']
      @post_to = BASE_URL + '/menu'
      render :action => "notfound.xml.builder", :layout => false
    end
    return
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:name, :extension, :phone)
    end
end
