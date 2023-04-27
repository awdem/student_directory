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

  describe '#find_by_id' do
    it 'returns a cohort object by id' do
      repo = CohortRepository.new

      cohort_2 = repo.find_by_id(2)

      expect(cohort_2.id).to eq "2"
      expect(cohort_2.cohort_name).to eq "January"
      expect(cohort_2.starting_date).to eq "2023-01-13"
      
    end
  end
      
  describe '#find_with_students' do
   it "returns a cohort object with students" do
    repo = CohortRepository.new

    cohort_with_students = repo.find_with_students(1)
    
    expect(cohort_with_students.id).to eq "1"
    expect(cohort_with_students.cohort_name).to eq "April"
    expect(cohort_with_students.starting_date).to eq "2023-04-13"

    students = cohort_with_students.students
    
    expect(students.length).to eq 2

    first_student = cohort_with_students.students.first 

    expect(first_student.id).to eq '1'
    expect(first_student.student_name).to eq 'David'
    expect(first_student.cohort_id).to eq '1'
   
    second_student = cohort_with_students.students.last
   
    expect(second_student.id).to eq '2'
    expect(second_student.student_name).to eq 'Emma'
    expect(second_student.cohort_id).to eq '1'
   end 
  end

  describe "#create" do
    it "creates a new cohort" do
      cohort = Cohort.new
      cohort.cohort_name = "new_cohort"
      cohort.starting_date = "2023-05-01"

      repo = CohortRepository.new

      repo.create(cohort)

      cohort_records = repo.all

      new_cohort = cohort_records.last

      expect(new_cohort.id).to eq "4"
      expect(new_cohort.cohort_name).to eq "new_cohort"
      expect(new_cohort.starting_date).to eq "2023-05-01"
    end
  end
  
end


