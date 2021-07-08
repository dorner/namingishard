import { Controller } from "stimulus"
import $ from 'jquery';
import Rails from "@rails/ujs"

export default class extends Controller {
  static targets = ["rating", "count"]
  static values = { url: String, word: String }

  connect() {
    let self = this;
    $('select.dropdown').dropdown({
      allowAdditions: true,
      onAdd: (value, text, $choice) => {
        self.addTag(value)
      },
      onRemove: (value, text, $choice) => {
        self.removeTag(value)
      }
    });

    $('.ui.rating', this.element).each((i, elem) => {
      let currRating = $(elem).data('rating');
      let disabled = $(elem).attr('disabled')
      $(elem).rating({
        maxRating: 5,
        clearable: false,
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

  addTag(value) {
    let data = new URLSearchParams();
    data.append('tag', value);
    data.append('word', this.wordValue)
    fetch('/tags', {
      method: 'post',
      body: data,
      headers: { 'X-CSRF_Token': Rails.csrfToken() }
    })
  }

  removeTag(value) {
    let data = new URLSearchParams();
    data.append('tag', value);
    data.append('word', this.wordValue)
    fetch('/tags/delete_tag', {
      method: 'post',
      body: data,
      headers: { 'X-CSRF_Token': Rails.csrfToken() }
    })
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
