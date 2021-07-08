import { Controller } from "stimulus"
import $ from 'jquery';
import Rails from "@rails/ujs"

export default class extends Controller {
  static values = { word: String }

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

}
