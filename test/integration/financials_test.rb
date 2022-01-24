require "test_helper"

class FinancialsTest < ActionDispatch::IntegrationTest
  test "financials page loads with tables" do
    get financials_path

    assert_select "h1", I18n.t("financials.show.title")
    assert_select "h2", I18n.t("financials.show.overview")
    assert_select "h2", I18n.t("financials.show.expenses")
    assert_select "h2", I18n.t("financials.show.revenue")
  end

  test "financials page loads overview table" do
    get financials_path

    assert_select "table#financials-overview" do
      assert_select "thead" do
        assert_select "tr" do
          assert_select "th:nth-child(1)", I18n.t("financials.show.date")
          assert_select "th:nth-child(2)", I18n.t("financials.show.revenue")
          assert_select "th:nth-child(3)", I18n.t("financials.show.expenses")
          assert_select "th:nth-child(4)", I18n.t("financials.show.total")
        end
      end

      assert_select "tbody" do
        assert_select "tr:nth-child(1)" do
          assert_select "td", 4
        end
      end
    end
  end

  test "financials page loads expenses table" do
    get financials_path

    assert_select "table#financials-expenses" do
      assert_select "thead" do
        assert_select "tr" do
          assert_select "th:nth-child(1)", I18n.t("financials.show.date")
          assert_select "th:nth-child(2)", I18n.t("financials.show.description")
          assert_select "th:nth-child(3)", I18n.t("financials.show.total")
        end
      end

      assert_select "tbody" do
        assert_select "tr:nth-child(1)" do
          assert_select "td", 3
        end
      end
    end
  end

  test "financials page loads revenue table" do
    get financials_path

    assert_select "table#financials-revenue" do
      assert_select "thead" do
        assert_select "tr" do
          assert_select "th:nth-child(1)", I18n.t("financials.show.date")
          assert_select "th:nth-child(2)", I18n.t("financials.show.source")
          assert_select "th:nth-child(3)", I18n.t("financials.show.revenue")
          assert_select "th:nth-child(4)", I18n.t("financials.show.stripe_fees")
          assert_select "th:nth-child(5)", I18n.t("financials.show.climate_contribution")
          assert_select "th:nth-child(6)", I18n.t("financials.show.net_revenue")
        end
      end
      assert_select "tbody" do
        assert_select "tr:nth-child(1)" do
          assert_select "td", 6
        end
      end
    end
  end
end
