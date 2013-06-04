require 'spec_helper'

describe Admin::UsersController do

  describe "For anonymous user" do
    it "should not show user list" do
      get 'index'
      response.should_not be_success
    end

    it "should not change admin rights" do
      put 'update'
      response.should_not be_success
    end
  end

  describe "For admins" do
    let(:admin) { FactoryGirl.create(:user, :is_admin => true) }
    before(:each) do
      sign_in admin
    end

    it "should show user list" do
      get 'index'
      response.should be_success
    end

    it "should change admins" do
      user = FactoryGirl.create(:user)
      put 'update', { :id => user.id, :attr => 'admin' }
      User.find(user.id).is_admin?.should be_true
    end

    it "should change ban state" do
      user = FactoryGirl.create(:user)
      put 'update', { :id => user.id, :attr => 'banned' }
      User.find(user.id).banned?.should be_true
    end

    context 'downloaded xls file' do
      before(:each) do
        @meetup = FactoryGirl.create(:meetup)
        @exp = FactoryGirl.create(:experience)
        @first_user = FactoryGirl.create(:user, :profile => FactoryGirl.create(:profile, :subscribed => true, :experience => @exp))
        @second_user = FactoryGirl.create(:user, :profile => FactoryGirl.create(:profile,:subscribed => true, :experience => @exp))
        participant = Participant.create(:meetup_id => @meetup.id, :user_id => @first_user.id)
        participant.user.index!
      end

      it 'should contain all users for "All" filter' do
        post 'index', { :format => 'xls' }
        response.header['Content-Disposition'].should include('Users.xls')
        file = StringIO.new(response.body)
        workbook = Spreadsheet.open file
        first_sheet = workbook.worksheet 0
        emails = [first_sheet.row(1).at(3), first_sheet.row(2).at(3), first_sheet.row(3).at(3)]
        emails.should include(@first_user.email)
        emails.should include(@second_user.email)
      end

      it 'should contain only participants of meetup for selected filter' do
        post 'index', { :format => 'xls', :filters => ["#{@meetup.id}"] }
        response.header['Content-Disposition'].should include('Users.xls')
        file = StringIO.new(response.body)
        workbook = Spreadsheet.open file
        first_sheet = workbook.worksheet 0
        first_sheet.row(1).at(3).should eq(@first_user.email)
        first_sheet.row(2).at(3).should eq(nil)
      end
    end
  end
end
