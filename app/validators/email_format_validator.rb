class EmailFormatValidator < ActiveModel::EachValidator
  def validate_each(record,attribute,value)
    # return ifはガード節であり、trueの場合は処理が中断(return)される
    # .match?()はRegExpクラスに使用可能。Stringクラスは.match()メソッドを使う
    return if /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.match?(value)

    record.errors.add(attribute, 'の形式が正しくありません')  
  end
end