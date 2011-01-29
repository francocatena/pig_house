require 'test_helper'

# Clase para probar el modelo "Pig"
class PigTest < ActiveSupport::TestCase
  fixtures :pigs

  # Función para inicializar las variables utilizadas en las pruebas
  def setup
    @pig = Pig.find pigs(:mother).id
  end

  # Prueba que se realicen las búsquedas como se espera
  test 'find' do
    assert_kind_of Pig, @pig
    assert_equal pigs(:mother).tag, @pig.tag
    assert_equal pigs(:mother).birth, @pig.birth
    assert_equal pigs(:mother).genetics, @pig.genetics
    assert_equal pigs(:mother).group, @pig.group
    assert_equal pigs(:mother).location, @pig.location
  end

  # Prueba la creación de un cerdo
  test 'create' do
    assert_difference 'Pig.count' do
      @pig = Pig.create(
        :tag => 'New tag',
        :birth => 10.days.ago.to_date,
        :genetics => 'New genetics',
        :group => 'New group',
        :location => 'New location'
      )
    end
  end

  # Prueba de actualización de un cerdo
  test 'update' do
    assert_no_difference 'Pig.count' do
      assert @pig.update_attributes(:tag => 'Updated tag'),
        @pig.errors.full_messages.join('; ')
    end

    assert_equal 'Updated tag', @pig.reload.tag
  end

  # Prueba de eliminación de cerdos
  test 'destroy' do
    assert_difference('Pig.count', -1) { @pig.destroy }
  end

  # Prueba que las validaciones del modelo se cumplan como es esperado
  test 'validates blank attributes' do
    @pig.tag = '  '
    assert @pig.invalid?
    assert_equal 1, @pig.errors.count
    assert_equal [error_message_from_model(@pig, :tag, :blank)],
      @pig.errors[:tag]
  end

  # Prueba que las validaciones del modelo se cumplan como es esperado
  test 'validates well formated attributes' do
    @pig.birth = '13/13/13'
    assert @pig.invalid?
    assert_equal 1, @pig.errors.count
    assert_equal [error_message_from_model(@pig, :birth, :invalid_date)],
      @pig.errors[:birth]
  end

  # Prueba que las validaciones del modelo se cumplan como es esperado
  test 'validates duplicated attributes' do
    @pig.tag = pigs(:stallion).tag
    assert @pig.invalid?
    assert_equal 1, @pig.errors.count
    assert_equal [error_message_from_model(@pig, :tag, :taken)],
      @pig.errors[:tag]
  end

  # Prueba que las validaciones del modelo se cumplan como es esperado
  test 'validates length of attributes' do
    @pig.tag = 'abcde' * 52
    @pig.genetics = 'abcde' * 52
    @pig.group = 'abcde' * 52
    @pig.location = 'abcde' * 52
    assert @pig.invalid?
    assert_equal 4, @pig.errors.count
    assert_equal [error_message_from_model(@pig, :tag, :too_long,
        :count => 255)], @pig.errors[:tag]
    assert_equal [error_message_from_model(@pig, :genetics, :too_long,
        :count => 255)], @pig.errors[:genetics]
    assert_equal [error_message_from_model(@pig, :group, :too_long,
        :count => 255)], @pig.errors[:group]
    assert_equal [error_message_from_model(@pig, :location, :too_long,
        :count => 255)], @pig.errors[:location]
  end
end