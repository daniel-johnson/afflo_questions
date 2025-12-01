=begin
  Task 4 - Lab Test Cumulative Results
  A patient, while on the waiting list for an organ donation, routinely has blood drawn to perform
  antigen tests to ensure compatibility with potential matches. A patient’s "cumulative crossmatch"
  is the result of combining all previous results into a running total, and comparing that result set
  against similar testing done against the donor organ.

  - Patients and donor organs can have a result of positive, negative, or indeterminate for each
  antigen tested

  - A patient’s "cumulative" result is the merged result of all individual tests with the following
  conditions:
    - Once marked positive, a patient is always considered to be positive for a specific antigen
    - A result of "indeterminate" simply means that was not tested, and should not affect overall
      results

  - A patient’s "crossmatch" is the list of matching positive, negative, and indeterminate results
  from the patient’s cumulative results and the donor organ

  A match is considered "recommended" if:
  - The patient is not marked positive for ANY antigen the donor organ is marked either "positive"
    or "indeterminate" for
  - patient antigen results marked "negative" do not affect recommendation status.

  A match is considered "viable with warnings" if:
  - The patient is not marked positive for ANY antigen that the donor organ is also marked
    "positive" for
  - There are donor results marked "indeterminate" for which the patient is "positive"

  A match is considered "rejected" if:
  - ANY antigen test result is marked "positive" for both the patient and the donor test results

# moved the example data to the spec file.

Write a function to take these two data sets in, and determine if the match is recommended,
viable with warnings, or not recommended.


==============================================================================================
Daniel's note:
  This was the most interesting by far! And I imagine it's a simplified case of part of
  your platform. I assume that the cumulative-crossmatch is be documented and reviewed in your
  platform, but for this is exercise it isn't necessary. 

  cumulative_analyser method returns a simple hash { "antigen_name": "antigen_value" }.
  This is different than the more descriptive given format for test data, but it simplifies
  the solution. In production code I'd want to document the transient format.
  That's something I really like from Typescript, all types must be documented.

  TODO constantize strings used internally as state, so typos
  give errors. Now that frozen_string_literal is turned on by default, it doesn't effect
  performance though.
----------------------------------------------------------------------------------------------
=end

class RecommendationService
  def self.cumulative_analyser(tests)
    cumulative = {}

    tests.each do |test|
      test[:test_results].each do |antigen|
        next if cumulative[antigen[:antigen]] == "positive"

        case antigen[:result]
        when "positive"
          cumulative[antigen[:antigen]] = "positive"
        when "negative"
          if cumulative[antigen[:antigen]] != "negative"
            cumulative[antigen[:antigen]] ||= "negative"
          end
        when "indeterminate"
          cumulative[antigen[:antigen]] ||= "indeterminate"
        end
      end
    end

    return cumulative
  end

  def self.recommendation_status(donor_results, patient_results)
    result = "recommended"
    cumulative = cumulative_analyser(patient_results)

    donor_results[:test_results].each do |donor_antigen|
      if donor_antigen[:result] == "positive" && cumulative[donor_antigen[:antigen]] == "positive"
        result = "rejected"
        break
      end

      if (donor_antigen[:result] == "indeterminate" && cumulative[donor_antigen[:antigen]] == "positive") ||
        (donor_antigen[:result] == "positive" && cumulative[donor_antigen[:antigen]] == "indeterminate")

        result = "viable with warnings"
        next
      end
    end

    return result
  end

end
