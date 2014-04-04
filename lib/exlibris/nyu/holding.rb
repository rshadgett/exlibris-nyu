module Exlibris
  module Nyu
    class Holding
      attr_reader :status, :status_display, :institution, :sub_library,
        :collection, :location, :call_number, :requestability, :extras

      def self.from_aleph(aleph_item)
        item = Item.new(aleph_item)
        attributes = {
          status: item.status,
          status_display: item.status_display,
          institution: item.institution,
          sub_library: item.sub_library,
          collection: item.collection,
          call_number: item.call_number,
          requestability: item.requestability,
          extras: {
            adm_library: item.adm_library,
            sub_library_code: item.sub_library_code,
            collection_code: item.collection_code,
            item_status_code: item.item_status_code,
            item_process_status_code: item.item_process_status_code,
            item_id: item.item_id,
            item_status: item.item_status,
            item_sequence_number: item.sequence_number,
            item_barcode: item.barcode,
            item_queue: item.queue
          }
        }
        self.new(attributes)
      end

      def initialize(attributes)
        @status = attributes[:status]
        @status_display = attributes[:status_display]
        # @status_display ||= mapped_status
        @sub_library = attributes[:sub_library]
        @institution = attributes[:institution]
        @collection = attributes[:collection]
        @location = "#{sub_library} #{collection}"
        @call_number = attributes[:call_number]
        @requestability = attributes[:requestability]
        @extras = attributes[:extras]
      end

      def to_h
        {
          status: status,
          status_display: status_display,
          sub_library: sub_library,
          collection: collection,
          call_number: call_number,
          requestability: requestability,
          extras: extras
        }
      end

      def always_requestable?
        requestability == Requestability::YES
      end

      def requestable?
        always_requestable? || requestability == Requestability::DEFERRED
      end
    end
  end
end
