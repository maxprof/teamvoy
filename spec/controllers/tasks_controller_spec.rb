require 'spec_helper'

RSpec.describe TasksController do

  describe "show action" do
    it "Should render show page" do
      sign_in FactoryGirl.create(:user)
      task = FactoryGirl.create(:task)
      get :show, {id: task.id}
      response.should render_template('show')
    end

    it "renders errors page if task not found" do
      get :show, {id: 0}
      response.status.should == 200
    end
  end

  describe "create action" do
    it "Should redirects to new page if validation faild" do
      sign_in FactoryGirl.create(:user)
      post :create, task: {title: "", description:""}
      response.should render_template('new')
    end

    it "Should redirects show page if validation pass" do
      sign_in FactoryGirl.create(:user)
      post :create, task: {title: "Test title",
            description:"asdasdasdasdasdasdasdasdasdasd"}
      response.should redirect_to(assigns(:task))
    end
  end

  describe "Destroy action" do
    it "redirects to task page when is destroyed successfully" do
      sign_in FactoryGirl.create(:user)
      task = FactoryGirl.create(:task)
      delete :destroy, id: task.id
    response.should redirect_to(root_path)
    end

    it "redirects to root_path if destroy not current user" do
      user = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      task = FactoryGirl.create(:task, user_id: user.id)
      sign_in user2
      delete :destroy, id: task.id
    response.should redirect_to(root_path)
    end
  end

  describe "PUT update" do
    it "redirects to task page when is updated successfully" do
      sign_in FactoryGirl.create(:user)
      task = FactoryGirl.create(:task)
      put :update, {id: task, task: FactoryGirl.attributes_for(:task, :tetle=>"Update attributes")}
      response.should redirect_to(assigns(:task))
    end

    it "redirects to root path when updates are not current user " do
      sign_in FactoryGirl.create(:user)
      task = FactoryGirl.create(:task)
      sign_in FactoryGirl.create(:user)
      put :update, {id: task, task: FactoryGirl.attributes_for(:task, :tetle=>"Update attributes")}
      response.should redirect_to(assigns(root_path))
    end
  end

end
