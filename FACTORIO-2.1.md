# Factorio 2.1 compatibility

Original prototype names and gameplay state are retained. The public mod uses its own namespace and imports the original state through native Factorio migrates_from ownership migration before legacy initialization can reset it. Test artifacts and raw player data are private.

Native Factorio 2.1.24 loaded the complete historical mod set, migrated its map and ran 600 simulation ticks. This is a headless result; it does not demonstrate a connected-client join or rendering.

Native loader flow passed all three tiers at four cardinal rotations, transferring and conserving exactly 100 items per layout. Current direction constants and built-event entities are used. Native --test-scenario checks also passed twelve actual test-player cursor builds and rotations, and forty-eight construction-robot blueprints covering every tier, cardinal rotation and horizontal/vertical mirror combination. Each robot-built layout transferred and conserved its two test items.
