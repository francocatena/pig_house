require 'test_helper'

# Clase para probar el modelo "Delivery"
class DeliveryTest < ActiveSupport::TestCase
  fixtures :deliveries

  # Función para inicializar las variables utilizadas en las pruebas
  def setup
    @delivery = Delivery.find deliveries(:mother_1).id
  end

  # Prueba que se realicen las búsquedas como se espera
  test 'find' do
    assert_kind_of Delivery, @delivery
    assert_equal deliveries(:mother_1).date, @delivery.date
    assert_equal deliveries(:mother_1).born, @delivery.born
    assert_equal deliveries(:mother_1).live, @delivery.live
    assert_equal deliveries(:mother_1).dead, @delivery.dead
    assert_equal deliveries(:mother_1).mummified, @delivery.mummified
    assert_equal deliveries(:mother_1).adopted, @delivery.adopted
    assert_equal deliveries(:mother_1).pig_id, @delivery.pig_id
  end

  # Prueba la creación de un cerdo
  test 'create' do
    assert_difference 'Delivery.count' do
      @delivery = Delivery.create(
        :date => Date.today,
        :born => 15,
        :live => 15,
        :dead => 0,
        :mummified => 0,
        :adopted => -1,
        :low => 0
      )
    end
  end

  # Prueba de actualización de un cerdo
  test 'update' do
    assert_no_difference 'Delivery.count' do
      assert @delivery.update_attributes(:born => 150),
        @delivery.errors.full_messages.join('; ')
    end

    assert_equal 150, @delivery.reload.born
  end

  # Prueba de eliminación de cerdos
  test 'destroy' do
    assert_difference('Delivery.count', -1) { @delivery.destroy }
  end

  # Prueba que las validaciones del modelo se cumplan como es esperado
  test 'validates blank attributes' do
    @delivery.date = nil
    @delivery.born = nil
    @delivery.live = nil
    @delivery.dead = nil
    @delivery.mummified = nil
    @delivery.adopted = nil
    @delivery.low = nil
    assert @delivery.invalid?
    assert_equal 7, @delivery.errors.count
    assert_equal [error_message_from_model(@delivery, :date, :blank)],
      @delivery.errors[:date]
    assert_equal [error_message_from_model(@delivery, :born, :blank)],
      @delivery.errors[:born]
    assert_equal [error_message_from_model(@delivery, :live, :blank)],
      @delivery.errors[:live]
    assert_equal [error_message_from_model(@delivery, :dead, :blank)],
      @delivery.errors[:dead]
    assert_equal [error_message_from_model(@delivery, :mummified, :blank)],
      @delivery.errors[:mummified]
    assert_equal [error_message_from_model(@delivery, :adopted, :blank)],
      @delivery.errors[:adopted]
    assert_equal [error_message_from_model(@delivery, :low, :blank)],
      @delivery.errors[:low]
  end

  # Prueba que las validaciones del modelo se cumplan como es esperado
  test 'validates well formated attributes' do
    @delivery.date = '13/13/13'
    @delivery.born = '1x'
    @delivery.live = '1.0'
    @delivery.dead = '1.0'
    @delivery.mummified = '1.0'
    @delivery.adopted = '1.0'
    @delivery.low = '1.0'
    assert @delivery.invalid?
    assert_equal 8, @delivery.errors.count
    assert_equal [error_message_from_model(@delivery, :date, :invalid_date),
      error_message_from_model(@delivery, :date, :blank)].sort,
      @delivery.errors[:date].sort
    assert_equal [error_message_from_model(@delivery, :born, :not_a_number)],
      @delivery.errors[:born]
    assert_equal [error_message_from_model(@delivery, :live, :not_an_integer)],
      @delivery.errors[:live]
    assert_equal [error_message_from_model(@delivery, :dead, :not_an_integer)],
      @delivery.errors[:dead]
    assert_equal [error_message_from_model(@delivery, :mummified,
        :not_an_integer)], @delivery.errors[:mummified]
    assert_equal [error_message_from_model(@delivery, :adopted,
        :not_an_integer)], @delivery.errors[:adopted]
    assert_equal [error_message_from_model(@delivery, :low, :not_an_integer)],
      @delivery.errors[:low]
  end
end