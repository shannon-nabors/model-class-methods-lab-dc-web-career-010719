class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name:'Catamaran'})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name:'Sailboat'}).uniq
  end

  def self.motorers
    includes(boats: :classifications).where(classifications: {name:'Motorboat'}).uniq
  end

  def self.talented_seafarers
    self.where("name in (?)", self.sailors.pluck(:name) & self.motorers.pluck(:name))
  end

  def self.non_sailors
    where.not("name in (?)", self.sailors.pluck(:name))
  end
end
