require 'test_helper'

# Clase para probar el modelo "Service"
class ServiceTest < ActiveSupport::TestCase
  fixtures :services

  # Función para inicializar las variables utilizadas en las pruebas
  def setup
    @service = Service.find services(:mother_S01).id
  end

  # Prueba que se realicen las búsquedas como se espera
  test 'find' do
    assert_kind_of Service, @service
    assert_equal services(:mother_S01).date, @service.date
    assert_equal services(:mother_S01).stallion, @service.stallion
    assert_equal services(:mother_S01).pig_id, @service.pig_id
  end

  # Prueba la creación de un cerdo
  test 'create' do
    assert_difference 'Service.count' do
      @service = Service.create(
        :date => Date.today,
        :stallion => 'SXX',
        :pig => pigs(:mother)
      )
    end
  end

  # Prueba de actualización de un cerdo
  test 'update' do
    assert_no_difference 'Service.count' do
      assert @service.update_attributes(:stallion => 'USXX'),
        @service.errors.full_messages.join('; ')
    end

    assert_equal 'USXX', @service.reload.stallion
  end

  # Prueba de eliminación de cerdos
  test 'destroy' do
    assert_difference('Service.count', -1) { @service.destroy }
  end

  # Prueba que las validaciones del modelo se cumplan como es esperado
  test 'validates blank attributes' do
    @service.date = nil
    assert @service.invalid?
    assert_equal 1, @service.errors.count
    assert_equal [error_message_from_model(@service, :date, :blank)],
      @service.errors[:date]
  end

  # Prueba que las validaciones del modelo se cumplan como es esperado
  test 'validates well formated attributes' do
    @service.date = '13/13/13'
    assert @service.invalid?
    assert_equal 2, @service.errors.count
    assert_equal [error_message_from_model(@service, :date, :invalid_date),
      error_message_from_model(@service, :date, :blank)].sort,
      @service.errors[:date].sort
  end

  # Prueba que las validaciones del modelo se cumplan como es esperado
  test 'validates length of attributes' do
    @service.stallion = 'abcde' * 52
    assert @service.invalid?
    assert_equal 1, @service.errors.count
    assert_equal [error_message_from_model(@service, :stallion, :too_long,
        :count => 255)], @service.errors[:stallion]
  end
end