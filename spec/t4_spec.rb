require_relative "../questions/t4"

positive_patient = [
  {
    "donor_id": 111503,
    "test_results": [{
        "antigen": "A1",
        "result": "positive"
      }
    ]
  }, {
    "donor_id": 111503,
    "test_results": [{
        "antigen": "A1",
        "result": "negative"
      }
    ]
  }, {
    "donor_id": 111503,
    "test_results": [{
        "antigen": "A1",
        "result": "indeterminate"
      }
    ]
  }
]

negative_patient = [
  {
    "donor_id": 111503,
    "test_results": [{
        "antigen": "A1",
        "result": "negative"
      }
    ]
  }, 
  {
    "donor_id": 111503,
    "test_results": [{
        "antigen": "A1",
        "result": "indeterminate"
      }
    ]
  }
]

indeterminate_patient = [
  {
    "donor_id": 111503,
    "test_results": [
      {
        "antigen": "A1",
        "result": "indeterminate"
      }
    ]
  }
]

positive_donor = {
  "donor_id": 349859,
  "test_results": [{
      "antigen": "A1",
      "result": "positive"
    }
  ]
}

negative_donor = {
  "donor_id": 982745,
  "test_results": [{
      "antigen": "A1",
      "result": "negative"
    }
  ]
}

indeterminate_donor = {
  "donor_id": 982745,
  "test_results": [{
      "antigen": "A1",
      "result": "indeterminate"
    }
  ]
}

# I wrapped the patient results hashes in an array, it wasn't in the pdf.
example_patient = [
  {
    "patient_id": 937421,
    "test_results": [{
        "antigen": "A1",
        "result": "negative"
      },
      {
        "antigen": "A2",
        "result": "indeterminate"
      },
      {
        "antigen": "A1B",
        "result": "negative"
      },
      {
        "antigen": "B1",
        "result": "negative"
      },
      {
        "antigen": "B2",
        "result": "indeterminate"
      },
      {
        "antigen": "B9",
        "result": "negative"
      }
    ]
  }, {
    "patient_id": 937421,
    "test_results": [{
        "antigen": "A1",
        "result": "positive"
      },
      {
        "antigen": "A2",
        "result": "negative"
      },
      {
        "antigen": "A1B",
        "result": "indeterminate"
      },
      {
        "antigen": "B1",
        "result": "negative"
      },
      {
        "antigen": "B2",
        "result": "negative"
      },

      {
        "antigen": "B9",
        "result": "negative"
      }
    ]
  }, {
    "patient_id": 937421,
    "test_results": [{
        "antigen": "A1",
        "result": "negative"
      },
      {
        "antigen": "A2",
        "result": "negative"
      },
      {
        "antigen": "A1B",
        "result": "negative"
      },
      {
        "antigen": "B1",
        "result": "indeterminate"
      },
      {
        "antigen": "B2",
        "result": "negative"
      },
      {
        "antigen": "B9",
        "result": "indeterminate"
      }
    ]
  }, {
    "patient_id": 937421,
    "test_results": [{
        "antigen": "A1",
        "result": "negative"
      },
      {
        "antigen": "A2",
        "result": "negative"
      },
      {
        "antigen": "A1B",
        "result": "negative"
      },
      {
        "antigen": "B1",
        "result": "negative"
      },
      {
        "antigen": "B2",
        "result": "negative"
      },
      {
        "antigen": "B9",
        "result": "positive"
      }
    ]
  }, {
    "patient_id": 937421,
    "test_results": [{
        "antigen": "A1",
        "result": "negative"
      },
      {
        "antigen": "A2",
        "result": "indeterminate"
      },
      {
        "antigen": "A1B",
        "result": "indeterminate"
      },
      {
        "antigen": "B1",
        "result": "negative"
      },
      {
        "antigen": "B2",
        "result": "negative"
      },
      {
        "antigen": "B9",
        "result": "negative"
      }
    ]
  }
]

example_donor = {
  "donor_id": 111503,
  "test_results": [{
      "antigen": "A1",
      "result": "negative"
    },
    {
      "antigen": "A2",
      "result": "negative"
    },
    {
      "antigen": "A1B",
      "result": "negative"
    },
    {
      "antigen": "B1",
      "result": "positive"
    },
    {
      "antigen": "B2",
      "result": "negative"
    },
    {
      "antigen": "B9",
      "result": "indeterminate"
    }
  ]
}

RSpec.describe RecommendationService do
  describe '#cumulative_analyser' do
    it 'returns positive for an antigen if there are any positive results' do
      expect(
        RecommendationService.cumulative_analyser(positive_patient)
      ).to eq({"A1" => "positive"})
    end

    it 'returns negative for an antigen if there are no positive results' do
      expect(
        RecommendationService.cumulative_analyser(negative_patient)
      ).to eq({"A1" => "negative"})
    end
  end

  describe '#recommendation_status' do
    it 'returns "rejected" when both have a positive result for the same antigen' do
      expect(
        RecommendationService.recommendation_status(positive_donor, positive_patient)
      ).to eq("rejected")
    end

    it 'returns "viable with warnings" when donor is positive for antigen that patient is inderminate for' do
      expect(
        RecommendationService.recommendation_status(positive_donor, indeterminate_patient)
      ).to eq("viable with warnings")
    end

    it 'returns "viable with warnings" when donor is inderminate for antigen that patient is positive for' do
      expect(
        RecommendationService.recommendation_status(indeterminate_donor, positive_patient)
      ).to eq("viable with warnings")
    end

    it 'returns "recommended" when donor is "negative" for antigen that patient is "negative" for' do
      expect(
        RecommendationService.recommendation_status(negative_donor, negative_patient)
      ).to eq("recommended")
    end
  end

  it 'returns "viable with warnings" when using the example data' do
    expect(
        RecommendationService.recommendation_status(example_donor, example_patient)
      ).to eq("viable with warnings")
  end
end
