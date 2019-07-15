window.hancock_cms.goto.constructGotoLink = (a, opts = {})->
  a = $(a)
  href = a.attr('href')
  defOpts = {
    target: '_blank',
    rel: 'nofollow noindex noopener'
  }
  opts = Object.assign({}, defOpts, opts)
  a.attr('data-href', href)
    .attr('data-gotohref', "/goto?url=#{escape(href)}")
    # .attr('onclick', "var link = this.cloneNode(true); link.href = link.getAttribute('data-gotohref'); link.onclick = null; link.click(); return false;")
    .attr('onclick', "var link = this.cloneNode(true); link.href = link.getAttribute('data-gotohref'); link.removeAttribute('onclick'); window.hancock_cms.goto.fireClick(link); return false;")
    .attr('data-gotolink', 'true')

  for attr of opts
    a.attr(attr, opts[attr])
  a
