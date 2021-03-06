require 'rails_helper'
include RandomData
RSpec.describe AdvertisementsController, type: :controller do
  let (:my_ad) do
    Advertisement.create!(
      id: 1,
      title: RandomData.random_sentence,
      copy:  RandomData.random_paragraph,
      price: 99
    )
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_ad] to @advertisemens" do
      get :index
      expect(assigns(:advertisemens)).to eq([my_ad])
    end
  end

  describe "GET show" do
    it "retirns http success" do
      get :show, params: {id: my_ad.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, params: {id: my_ad.id}
      expect(response).to render_template :show
    end

    it "renders my_ad to @advertisement" do
      get :show, params: {id: my_ad.id}
      expect(assigns(:advertisement)).to eq(my_ad)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "instaniates @advertisement" do
      get :new
      expect(assigns(:advertisement)).not_to be_nill
    end
  end

  describe "POST create" do
    it "increase the number of advertisements by 1 " do
      expect{post :create, advertisement: {title: RandomData.random_sentence, copy: RandomData.random_paragraph, price: 99}}.to
      change(Advertisement,:count.by(1))
    end

    it "assigns the new advertisement to @advertisement" do
      post :create, advertisement: {title: RandomData.random_sentence, copy: RandomData.random_paragraph, price: 99}
      expect(assigns(:advertisement)).to eq Advertisement.last
    end

    it "redirects to the new advertisement" do
      post :create, advertisement: {title: RandomData.random_sentence, copy: RandomData.random_paragraph, price: 99}
      expect(response).to Advertisement.last
    end

  end
end
