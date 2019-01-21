class Cluster < PantauAuthApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: :requester_id
end
