#!/usr/bin/env ruby
# Rails 8対応のための一括修正スクリプト 🚀

require 'find'
require 'fileutils'

puts "🚀 Rails 8対応の一括修正を開始します..."

# 修正対象のディレクトリ
VIEW_DIRS = ['app/views']
EXCLUDE_DIRS = ['.git', 'vendor', 'node_modules', 'tmp', 'log']

# 修正パターン
REPLACEMENTS = [
  # method: :delete を data: { "turbo-method": :delete } に変更
  [/method:\s*:delete/, 'data: { "turbo-method": :delete }'],
  
  # method: :patch を data: { "turbo-method": :patch } に変更  
  [/method:\s*:patch/, 'data: { "turbo-method": :patch }'],
  
  # method: :put を data: { "turbo-method": :put } に変更
  [/method:\s*:put/, 'data: { "turbo-method": :put }'],
  
  # confirm: を "turbo-confirm": に変更
  [/confirm:\s*"([^"]*)"/, '"turbo-confirm": "\1"'],
  
  # data: { confirm: を data: { "turbo-confirm": に変更
  [/data:\s*{\s*confirm:\s*"([^"]*)"/, 'data: { "turbo-confirm": "\1"']
]

# GETメソッドは変更しないファイルパターン
GET_KEEP_PATTERNS = [
  /method:\s*:get/,
  /html:\s*{\s*method:\s*:get\s*}/,
  /url:.*method:\s*:get/
]

def should_exclude_dir?(path)
  EXCLUDE_DIRS.any? { |exclude| path.include?(exclude) }
end

def should_keep_get_method?(line)
  GET_KEEP_PATTERNS.any? { |pattern| line.match?(pattern) }
end

def process_file(file_path)
  return unless File.exist?(file_path)
  return unless file_path.end_with?('.erb', '.rb')
  
  content = File.read(file_path, encoding: 'UTF-8')
  original_content = content.dup
  modified = false
  
  REPLACEMENTS.each do |pattern, replacement|
    content.gsub!(pattern) do |match|
      # GETメソッドの場合は変更しない
      if should_keep_get_method?($&)
        match
      else
        modified = true
        replacement
      end
    end
  end
  
  if modified
    File.write(file_path, content, encoding: 'UTF-8')
    puts "✅ 修正: #{file_path}"
    return true
  end
  
  false
end

# メイン処理
total_files = 0
modified_files = 0

VIEW_DIRS.each do |dir|
  next unless Dir.exist?(dir)
  
  Find.find(dir) do |path|
    if File.directory?(path)
      Find.prune if should_exclude_dir?(path)
      next
    end
    
    next unless File.file?(path)
    total_files += 1
    
    if process_file(path)
      modified_files += 1
    end
  end
end

puts ""
puts "🎉 Rails 8対応修正完了!"
puts "📊 処理したファイル: #{total_files}"
puts "✨ 修正されたファイル: #{modified_files}"
puts ""

if modified_files > 0
  puts "📝 主な修正内容:"
  puts "  - method: :delete → data: { \"turbo-method\": :delete }"
  puts "  - method: :patch → data: { \"turbo-method\": :patch }"
  puts "  - method: :put → data: { \"turbo-method\": :put }"
  puts "  - confirm: → \"turbo-confirm\":"
  puts ""
  puts "⚠️  注意: GETメソッドは変更していません（正常な動作のため）"
else
  puts "ℹ️  修正が必要なファイルは見つかりませんでした。"
end