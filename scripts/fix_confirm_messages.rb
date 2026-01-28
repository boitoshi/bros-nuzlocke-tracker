#!/usr/bin/env ruby
# frozen_string_literal: true

# turbo-confirm メッセージの修正スクリプト 🔧

require 'find'

puts '🔧 turbo-confirm メッセージを修正します...'

# 修正対象の置換パターン
CONFIRM_FIXES = {
  '"turbo-confirm": "\1"' => '"turbo-confirm": "本当に実行しますか？"',
  '"turbo-confirm": "\\1"' => '"turbo-confirm": "本当に実行しますか？"'
}.freeze

def process_file(file_path)
  return unless File.exist?(file_path)
  return unless file_path.end_with?('.erb')

  content = File.read(file_path, encoding: 'UTF-8')
  content.dup
  modified = false

  CONFIRM_FIXES.each do |pattern, replacement|
    if content.include?(pattern)
      content.gsub!(pattern, replacement)
      modified = true
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

Find.find('app/views') do |path|
  next unless File.file?(path)
  next unless path.end_with?('.erb')

  total_files += 1

  modified_files += 1 if process_file(path)
end

puts ''
puts '🎉 turbo-confirm修正完了!'
puts "📊 処理したファイル: #{total_files}"
puts "✨ 修正されたファイル: #{modified_files}"
