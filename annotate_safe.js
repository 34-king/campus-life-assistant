const fs = require('fs');
const bom = '\uFEFF';

// Annotation table: file -> annotation comment
const annotations = {
  'lib/main.dart': '// [AI-GEN] App entry, routing, theme config. [HUMAN] MultiProvider setup, route additions.',
  'lib/models/school_data.dart': '// [AI-GEN] Data models and mock data. [HUMAN] Added card/grade/calendar models.',
  'lib/providers/favorites_provider.dart': '// [AI-GEN] Favorites state management. [HUMAN] Added SharedPreferences persistence.',
  'lib/providers/theme_provider.dart': '// [AI-GEN] Theme management with persistence.',
  'lib/pages/splash_page.dart': '// [AI-GEN] Splash screen with fade animation.',
  'lib/pages/home_page.dart': '// [AI-GEN] Home page layout. [HUMAN] Real-time weather API (wttr.in) implementation.',
  'lib/pages/schedule_page.dart': '// [AI-GEN] Weekly schedule grid view.',
  'lib/pages/canteen_page.dart': '// [AI-GEN] Canteen menu with tabs and favorites.',
  'lib/pages/notice_page.dart': '// [AI-GEN] Notice list with detail bottom sheet.',
  'lib/pages/card_page.dart': '// [AI-GEN] Virtual campus card with balance and transactions.',
  'lib/pages/grade_page.dart': '// [AI-GEN] Grade query with GPA calculation.',
  'lib/pages/calendar_page.dart': '// [AI-GEN] Calendar view with event markers.',
  'lib/pages/map_page.dart': '// [AI-GEN] Campus map with building grid.',
  'lib/pages/profile_page.dart': '// [AI-GEN] User profile and menu entries.',
  'lib/pages/favorites_page.dart': '// [AI-GEN] Favorites list (dishes + notices).',
  'lib/pages/settings_page.dart': '// [AI-GEN] Settings with theme toggle.',
  'test/widget_test.dart': '// [AI-GEN] Basic widget test.',
};

const base = 'C:\\Users\\HASEE\\Desktop\\xyshzsapp\\';

let count = 0;
for (const [relPath, annotation] of Object.entries(annotations)) {
  const fullPath = base + relPath.replace(/\//g, '\\');
  try {
    const buf = fs.readFileSync(fullPath);
    let content = buf.toString('utf-8');
    
    // Remove existing BOM if present
    if (content.charCodeAt(0) === 0xFEFF) {
      content = content.substring(1);
    }
    
    // Remove any existing AI-GEN or HUMAN annotations (in case of re-run)
    const lines = content.split('\n').filter(line => {
      const trimmed = line.trim();
      return !trimmed.startsWith('// [AI-GEN]') && !trimmed.startsWith('// [HUMAN]');
    });
    
    // Prepend the annotation
    lines.unshift(annotation);
    
    // Write back with BOM
    const newContent = bom + lines.join('\n');
    fs.writeFileSync(fullPath, newContent, 'utf-8');
    count++;
    console.log('OK: ' + relPath);
  } catch(e) {
    console.log('ERR: ' + relPath + ' - ' + e.message);
  }
}

console.log('\nDone: ' + count + ' files annotated');
