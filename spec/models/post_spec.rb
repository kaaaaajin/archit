# frozen_string_literal: true
require 'rails_helper'

  RSpec.describe Post, "モデルに関するテスト", type: :model do
    describe "実際に保存してみる" do
      it "有効な投稿内容の場合は保存されるか" do
        expect(FactoryBot.build(:post)).to be_valid
      end
    end
    context "空白のバリデーションチェック" do
      it "architectureが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
        post = Post.new(architecture: '',architect: 'name',address: 'hoge',body: 'body')
        expect(post).to be_invalid
        expect(post.errors[:architecture]).to include("入力してください")
      end
      it "architectが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
        post = Post.new(architecture: 'hoge',architect: '',address: 'hoge',body: 'body')
        expect(post).to be_invalid
        expect(post.errors[:architect]).to include("入力してください")
      end
      it "addressが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
        post = Post.new(architecture: 'hoge',architect: 'name',address: '',body: 'body')
        expect(post).to be_invalid
        expect(post.errors[:address]).to include("入力してください")
      end 
  　end
  end
  
end