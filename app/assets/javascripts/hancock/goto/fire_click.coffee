window.hancock_cms.goto.fireClick = (node) ->
  if document.createEvent
    evt = document.createEvent('MouseEvents')
    evt.initEvent 'click', true, false
    node.dispatchEvent evt
  else if document.createEventObject
    node.fireEvent 'onclick'
  else if typeof node.onclick == 'function'
    node.onclick()
  else
    node.click()
  return
