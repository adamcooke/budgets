class AddUuidToExistingData < ActiveRecord::Migration
  def change
    Line.where(:uuid => nil).all.each { |l| l.update(:uuid => SecureRandom.uuid) }
    Account.where(:uuid => nil).all.each { |l| l.update(:uuid => SecureRandom.uuid) }
    Organization.where(:uuid => nil).all.each { |l| l.update(:uuid => SecureRandom.uuid) }
    Period.where(:uuid => nil).all.each { |l| l.update(:uuid => SecureRandom.uuid) }
  end
end
