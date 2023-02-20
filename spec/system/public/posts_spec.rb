# frozen_string_literal: true

require 'rails_helper'

describe "投稿のテスト" do
  let!(:post) { create(:post, architecture: 'hoge',architect: 'name',address: 'hoge',body: 'body') }
  describe "投稿フォーム(new_post_path)のテスト" do
    before do
      visit new_post_path
    end
    context "表示の確認" do
      it 'new_post_pathが"/posts/new"であるか' do
        expect(current_path).to eq('/posts/new')
      end
      it "投稿ボタンが表示されているか" do
        expect(page).to have_button "投稿する"
      end
    end
    context "投稿処理のテスト" do
      it "投稿後のリダイレクト先は正しいか" do
        fill_in 'post[architecture]', with: Faker::Lorem.characters(number:10)
        fill_in 'post[architect]', with: Faker::Name.name  
        fill_in 'post[address]', with: Faker::Address.full_address
        fill_in 'post[body]', with: Faker::Lorem.characters(number:20)
        click_button "投稿する"
        expect(page).to have_current_path post_path(Post.last)
      end
    end
  end
  
  describe "投稿一覧画面のテスト" do
    before do
      visit posts_path
    end
    # context "表示の確認" do
      # it "投稿画像が表示されているか" do
        # expect(page).to 
    # end
    # end
  end
  
  describe "投稿詳細画面のテスト" do
    before do
      visit post_path(post)
    end
    context "表示の確認" do
      it "削除リンクが存在しているか" do
        expect(page).to have_link "削除"
      end
      it "編集リンクが存在しているか" do
        expect(page).to have_link "編集"
      end
    end
  end
  
  describe "編集画面のテスト" do
    before do
      visit edit_post_path(post)
    end
    context "表示の確認" do
      it "編集前の投稿内容がフォームにセットされているか" do
        expect(page).to have_field 'post[architecture]', with: post.architecture
        expect(page).to have_field 'post[architect]', with: post.architect
        expect(page).to have_field 'post[address]', with: post.address
        expect(page).to have_field 'post[body]', with: post.body
      end
      it "保存ボタンが表示されているか" do
        expect(page).to have_button "変更を保存"
      end
    end
    context "更新処理に関するテスト" do
      it "更新後のリダイレクト先は正しいか" do
        fill_in 'post[architecture]', with: Faker::Lorem.characters(number:10)
        fill_in 'post[architect]', with: Faker::Name.name
        fill_in 'post[address]', with: Faker::Address.full_address
        fill_in 'post[body]', with: Faker::Lorem.characters(number:20)
        click_button "変更を保存"
        expect(page).to have_current_path post_path(post)
      end
    end
  end
end