class String
  # 全角半角空白削除
  def strip_all_space!
    gsub!(/(^[[:space:]]+)|([[:space:]]+$)/, '')
    gsub!(/[[:blank:]]+/, ' ')
  end

  def strip_all_space
    self_clone = clone
    self_clone.strip_all_space!
    self_clone
  end
end
