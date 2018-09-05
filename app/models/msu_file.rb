class MsuFile < ApplicationRecord
  after_save :remove_empty_types

  belongs_to :msu_discipline
  belongs_to :msu_filetype
  
  validates :name, presence: true,
            uniqueness: {scope: :msu_discipline}

  default_scope { order("created_at DESC") }

  mount_uploader :file, AttachmentUploader

  def filetype
    msu_filetype.name if msu_filetype
  end

  def filetype=(f)
    self[:msu_filetype_id] = MsuFiletype.find_or_create_by(name: f).id
  end

  def remove_empty_types
    MsuFiletype.all.each do |f|
      f.destroy unless f.msu_files.any?
    end
  end

end
