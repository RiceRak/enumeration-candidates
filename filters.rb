# In this file we define the methods to help filter out candidates
# This way, we keep these methods separated from other potential parts of the program

require './candidates'

def find(id)
    # Your code Here
    @candidates.find { |candidate| candidate.id == id }
  end
  
  def experienced?(candidate)
    # Your code Here
    candidate[:years_of_experience] >=2
  end

=begin
- Takes in the collection of candidates
- Returns a subset of the candidates that meet the following criteria:
Are experienced - experienced?
Have 100 or more Github points - 100_plus_github_points?
Know at least Ruby or Python - ruby_or_python?
Applied in the last 15 days - recently_applied?
Are over the age of 17 (18+)
=end

  
def qualified_candidates(candidates)
  @candidates.select do |candidate|
    experienced?(candidate) &&
    onehundred_plus_github_points?(candidate) &&
    ruby_or_python?(candidate) &&
    recently_applied?(candidate) &&
    over_18?(candidate)
  end
end
  
  # More methods will go below

def onehundred_plus_github_points?(candidate)
  candidate[:github_points] >=100
end

def ruby_or_python?(candidate)
  candidate[:languages].include?("Ruby") || candidate[:languages].include?("Python")
end

def recently_applied?(candidate)
  (Date.today - candidate[:date_applied]).to_i <= 15
end

def over_18?(candidate)
 candidate[:age] >= 18
end 


qualified = qualified_candidates(@candidates)

puts "Qualified Candidates:"
qualified.each do |candidate|
  puts "ID: #{candidate[:id]}, Experience: #{candidate[:years_of_experience]} years, Github Points: #{candidate[:github_points]}, Languages: #{candidate[:languages].join(', ')}, Applied: #{candidate[:date_applied]} days ago, Age: #{candidate[:age]}"
end

def ordered_by_qualifications(candidates)
  candidates.sort_by { |candidate| [-candidate[:years_of_experience], -candidate[:github_points]] }
end