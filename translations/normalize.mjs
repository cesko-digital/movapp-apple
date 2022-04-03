import crypto from 'crypto'
import path from 'path'
import fs from 'fs'
import data from './in.json' assert { type: 'json' }

// Build list of sections and generate id
// Build a list of words and generate id
// map words ids to section ids

function saveJSON (content, file) {
	fs.writeFileSync(path.resolve(process.cwd(), file), JSON.stringify(content), 'utf8')
}


const sections = []
const translations = {}

let duplications = 0

for (const value of data) {
	const hash = crypto.createHash('md5')
	hash.update(value.category_name_cz);

	const sectionId = hash.digest('hex')
	const section = {
		id: sectionId,
		name_from: value.category_name_cz,
		name_to: value.category_name_ua,
		translations: []
	}
	sections.push(section)

	for (const translation of value.translations) {
		const hash = crypto.createHash('md5')
		hash.update(translation.cz_translation)
		const translationId = hash.digest('hex')

		section.translations.push(translationId)

		if (typeof translations[translationId] !== 'undefined') {
			translations[translationId].sectionIds.push(sectionId)
			//console.log('Duplication found', translations[translationId], translation)
			duplications++
			continue;
		}

		translations[translationId] = {
			id: translationId,
			sectionIds: [sectionId],
			translation_from: translation.cz_translation,
    		transcription_from: translation.cz_transcription,
    
    		translation_to: translation.ua_translation,
    		transcription_to: translation.ua_transcription,
		}
	}
}

saveJSON(sections, 'sections.json')
saveJSON(translations, 'translations.json')
