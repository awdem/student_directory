require 'cohort_repository'

def reset_test_tables
  seed_sql = File.read('spec/seed_directory.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2_test' })
  connection.exec(seed_sql)
end


RSpec.describe CohortRepository do
  before(:each) do 
    reset_test_tables
  end  

  describe "#all" do
    it "returns a list of all cohorts" do
      repo = CohortRepository.new
      results_set = repo.all

      expect(results_set.length).to eq 3

      cohort_1 = results_set.first
      expect(cohort_1.id).to eq "1"
      expect(cohort_1.cohort_name).to eq "April"
      expect(cohort_1.starting_date).to eq "2023-04-13"

      cohort_3 = results_set.last
      expect(cohort_3.id).to eq "3"
      expect(cohort_3.cohort_name).to eq "October"
      expect(cohort_3.starting_date).to eq "2023-10-13"
    end
  end
end