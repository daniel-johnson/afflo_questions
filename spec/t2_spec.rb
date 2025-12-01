require_relative "../questions/t2"

example_data = [
  { "test_id": "20251127-184", "result_id": 73, "comments": "No issues observed" },
  { "test_id": "20251127-991", "result_id": 7, "comments": "Below threshold" },
  { "test_id": "20251127-432", "result_id": 39, "comments": "Pending verification" },
  { "test_id": "20251127-120", "result_id": 88, "comments": "Stable reading" },
  { "test_id": "20251127-338", "result_id": 3, "comments": "Requires follow-up" },
  { "test_id": "20251127-742", "result_id": 64, "comments": "Acceptable variance" },
  { "test_id": "20251127-512", "result_id": 26, "comments": "No anomalies detected" },
  { "test_id": "20251127-991", "result_id": 94, "comments": "Above expected range" },
  { "test_id": "20251127-634", "result_id": 11, "comments": "Low priority" },
  { "test_id": "20251127-908", "result_id": 80, "comments": "Performance adequate" },
  { "test_id": "20251127-271", "result_id": 51, "comments": "Meets criteria" },
  { "test_id": "20251127-184", "result_id": 55, "comments": "Within expected range" },
  { "test_id": "20251127-880", "result_id": 42, "comments": "Under review" },
  { "test_id": "20251127-187", "result_id": 95, "comments": "High confidence result"},
  { "test_id": "20251127-184", "result_id": 12, "comments": "Review recommended" }
]

RSpec.describe IngestionService do
  describe "#clean_duplicates!" do
    it 'removes duplicate records' do
      data = example_data.dup
      expect(
        IngestionService.clean_duplicates!(data).count
      ).to(eq(12))
    end

    it 'mutates data in place' do
      data = example_data.dup
      data_object_id = data.object_id
      IngestionService.clean_duplicates!(data)

      expect(data.object_id).to eq(data_object_id)
    end
  end
end
