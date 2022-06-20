module UTCOffsets
  class Component < ApplicationComponent
    def initialize(utc_offset)
      @utc_offset = utc_offset
    end

    def formatted_utc_offset
      "#{t("utc_offsets.component.gmt")}#{plus_minus}#{utc_offset}"
    end

    private

    def plus_minus
      "+" if @utc_offset > 0
    end

    def utc_offset
      utc_offset = @utc_offset.fdiv(SECONDS_IN_AN_HOUR)
      unless utc_offset == 0
        number_with_precision(utc_offset, precision: 1, strip_insignificant_zeros: true)
      end
    end
  end
end
