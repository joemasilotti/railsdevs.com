# https://github.com/ddnexus/pagy/blob/master/lib/config/pagy.rb

# Pagy initializer file (5.10.1)
# Please maintain the require-order of the extras from the above link.

# Overflow extra: Allow for easy handling of overflowing pages
# See https://ddnexus.github.io/pagy/extras/overflow
require "pagy/extras/overflow"
Pagy::DEFAULT[:overflow] = :last_page
