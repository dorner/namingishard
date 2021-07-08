import { Controller } from "stimulus"
import $ from 'jquery';
import Rails from "@rails/ujs"

export default class extends Controller {
  static targets = ["rating", "count"]
  static values = { url: String }

  connect() {
    let self = this;
    $('.ui.rating', this.element).each((i, elem) => {
      let currRating = $(elem).data('rating');
      let disabled = $(elem).attr('disabled')
      $(elem).rating({
        maxRating: 5,
        initialRating: currRating,
        interactive: !disabled,
        onRate: (val) => {
          // need to do this because otherwise it gets into an infinite loop when we set it on callback
          if ($(elem).data('programmatic-rating')) {
            $(elem).data('programmatic-rating', null);
            return;
          }
          self.vote(val);
        }
      });
      if ($(elem).data('content')) {
        $(elem).popup();
      }
  });
  }

  vote(score) {
    const url = this.urlValue
    let data = new URLSearchParams();
    data.append('score', score)
    fetch(url, {
      method: 'POST',
      body: data,
      headers: { 'X-CSRF_Token': Rails.csrfToken() }
    }).then((response) => {
      response.json().then((json) => {
        this.countTarget.innerHTML = json['count'];
        $(this.ratingTarget).data('programmatic-rating', true);
        $(this.ratingTarget).rating('set rating', json['score'])
      });
    })
  }

}
