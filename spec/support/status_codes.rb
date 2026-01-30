# Ensures `have_http_status(:unprocessable_entity)` works in this test suite
# (Rack 3 doesn't include :unprocessable_entity in SYMBOL_TO_STATUS_CODE by default)
Rack::Utils::SYMBOL_TO_STATUS_CODE[:unprocessable_entity] ||= 422
