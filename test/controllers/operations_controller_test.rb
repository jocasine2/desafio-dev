require "test_helper"

class OperationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @operation = operations(:one)
  end

  test "should get index" do
    get operations_url, as: :json
    assert_response :success
  end

  test "should create operation" do
    assert_difference('Operation.count') do
      post operations_url, params: { operation: { CPF: @operation.CPF, card_number: @operation.card_number, date: @operation.date, hour: @operation.hour, owner: @operation.owner, store_name: @operation.store_name, transaction_type_id: @operation.transaction_type_id, value: @operation.value } }, as: :json
    end

    assert_response 201
  end

  test "should show operation" do
    get operation_url(@operation), as: :json
    assert_response :success
  end

  test "should update operation" do
    patch operation_url(@operation), params: { operation: { CPF: @operation.CPF, card_number: @operation.card_number, date: @operation.date, hour: @operation.hour, owner: @operation.owner, store_name: @operation.store_name, transaction_type_id: @operation.transaction_type_id, value: @operation.value } }, as: :json
    assert_response 200
  end

  test "should destroy operation" do
    assert_difference('Operation.count', -1) do
      delete operation_url(@operation), as: :json
    end

    assert_response 204
  end
end
