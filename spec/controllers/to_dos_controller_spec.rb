require 'rails_helper'

RSpec.describe ToDosController, type: :controller do

  let!(:to_do) { create(:to_do, user_id: user.id) }
  let!(:to_do_finished) { create(:finished_to_do, user_id: user.id) }
  let!(:user) { create(:user) }

  let(:valid_attributes) {
    {
      title: "Comprar batata",
      deadline: "01/02/2017 23:00",
    }
  }

  let(:invalid_attributes) {
    {
      title: "Comprar batata",
    }
  }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  describe "GET #index" do
    it "retonrna um array com ToDo's ordenados por finished_at asc e deadline asc" do
      get :index
      expect(assigns(:todos)).to eq([to_do, to_do_finished])
    end
  end

  describe "POST #create" do
    context "com parâmetros válidos" do
      it "atribui um novo ToDo criado à variável de instância @to_do" do
        post :create, {:to_do => valid_attributes}
        expect(assigns(:to_do)).to be_a(ToDo)
        expect(assigns(:to_do)).to be_persisted
      end

      it "retorna status 302" do
        post :create, {:to_do => valid_attributes}
        expect(response.status).to eq(302)
      end
    end

    context "com parâmetros inválidos" do
      it "retorna status 500" do
        post :create, {:to_do => invalid_attributes}
        expect(assigns(:to_do)).to_not be_persisted
        expect(response.status).to eq(500)
      end
    end
  end

  describe "GET #finish" do
    it "a variável de instância @to_do deve ser persistida" do
      get :finish, id: to_do.id
      expect(assigns(:to_do)).to be_a(ToDo)
      expect(assigns(:to_do)).to be_persisted
    end

    it "os atributos status e finished_at devem ser modificados (status deve ser finished e finished_at não pode ser nulo)" do
      get :finish, id: to_do.id
      expect(assigns(:to_do).status).to eq(:finished)
      expect(assigns(:to_do).finished_at).to_not be_nil
    end
  end

  describe "GET #unfinish" do
    it "a variável de instância @to_do deve ser persistida" do
      get :unfinish, id: to_do.id
      expect(assigns(:to_do)).to be_a(ToDo)
      expect(assigns(:to_do)).to be_persisted
    end

    it "os atributos status e finished_at devem ser modificados (status deve ser pending e finished_at deve ser nulo)" do
      get :unfinish, id: to_do.id
      expect(assigns(:to_do).status).to eq(:pending)
      expect(assigns(:to_do).finished_at).to be_nil
    end
  end

  describe "DELETE #destroy" do
    it "o objeto cujo id foi passado como parâmetro pro método destroy deve ser deletado" do
      expect(ToDo.all.count).to eq(2)
      delete :destroy, id: to_do.id
      expect(ToDo.all.count).to eq(1)
    end
  end
end
