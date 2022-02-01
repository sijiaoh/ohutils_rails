def should_change_current_path
  current_path = page.current_path
  yield
  expect(page).not_to have_current_path current_path
end
