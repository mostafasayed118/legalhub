# Phase 3 — Stitch reference-frame staging manifest (final)

Staging directory: `docs/redesign/phase3/reference-frames/`
Stitch project: `projects/17670909757013221834` ("LegalHub Mobile App").

## Provenance

- Authoritative source: consolidated delivery ZIP downloaded from
  `https://muse.ai/files/1420881227778507/1838306113950495/q4v3hphop64a1iblhvintpfl/legalhub-phase3-reference-frames.zip`
  to `C:\Users\ASUS\AppData\Local\Temp\opencode\legalhub-phase3-reference-frames.zip`.
- ZIP size: **5,202,052 bytes** (matches the owner's stated size). `zipfile.testzip()` returned `None` (archive intact); 19 entries = 18 PNGs + `DELIVERY_MANIFEST.md`.
- Extracted to a temporary directory outside the staging directory:
  `C:\Users\ASUS\AppData\Local\Temp\opencode\phase3_delivery_extract`. Only `screen.png` exports (renamed by Muse) were copied into staging; `code.html`, `DESIGN.md`, and ZIPs were not staged.
- **Superseded source:** `C:\Users\ASUS\Downloads\stitch_legalhub_mobile_app.zip` (275,629 bytes) is the original single Sign In dark archive. Its `screen.png` SHA-256 is `ddc54f860a8484ef3ab7f34b4870eaceffe34187df72e2a3c68913b341f58c38`, **identical to row 2 below** (owner-confirmed actual, not the test-download duplicate). It is **superseded** by the consolidated delivery as the staging source and was not used for staging.
- The 18 original source ZIPs remain in the Muse workspace under `browser_downloads/node-session-6c52379e-b579-4f32-bf4d-977367457608/`; they are not staged here.

## Verification method

Every PNG was checked against `DELIVERY_MANIFEST.md` for: exact filename, exact byte size, exact pixel dimensions, exact colour mode, exact SHA-256, and successful PIL `verify()` + decode. **18/18 passed; 0 failures.** Staged copies were re-written from the verified temporary extract.

## Visual-inspection status (owner-stated, not agent visual review)

- **8 frames visually inspected by the owner and clean.** The authorization did not enumerate them individually; from the stated grouping (3 flagged dark artefacts + 7 light frames identity-only), the two light frames among the clean eight are Account light and Delete Account light, with Sign In/Sign Up/Forgot Email/OTP/Reset/Onboarding/Onboarding Success light being the seven identity-only frames. Owner to correct this attribution if needed.
- **7 light frames:** matched by original ZIP byte size and node ID, **not** visually inspected by the owner. Identity/readability verified here by hash, size, dimensions and decode only.
- **3 dark exports:** visually inspected by the owner and flagged as artefacts (rows 10, 16, 18 below). The agent did **not** independently visually inspect all 18 designs.

## 18-frame verification table

| # | Surface / variant | Full Stitch node ID | Staged filename | Source ZIP | PNG bytes exp / act | Dimensions exp / act | Mode exp / act | SHA-256 exp / act (= match) | Readable | Owner visual status |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | Sign In light | `54416f7ad13f4b009ffe50b69f97c0ff` | `sign-in-light-54416f7ad13f4b009ffe50b69f97c0ff.png` | consolidated delivery ZIP (orig. 112,492 B) | 113,390 / 113,390 | 633×1436 / 633×1436 | RGBA / RGBA | `49effa70d857e2382d79f12707e6fb5ee30a9b22317b5d9a452761da341fb81c` = | PASS | identity/hash only |
| 2 | Sign In dark | `6d476f197d98420fa2af90cf57a32403` | `sign-in-dark-6d476f197d98420fa2af90cf57a32403.png` | consolidated delivery ZIP (orig. 275,629 B; Downloads archive superseded) | 272,389 / 272,389 | 706×1600 / 706×1600 | RGB / RGB | `ddc54f860a8484ef3ab7f34b4870eaceffe34187df72e2a3c68913b341f58c38` = | PASS | visually inspected, clean |
| 3 | Sign Up light | `a0f76486f67e4c77a5ff624624eed19d` | `sign-up-light-a0f76486f67e4c77a5ff624624eed19d.png` | consolidated delivery ZIP (orig. 143,853 B) | 144,982 / 144,982 | 706×1600 / 706×1600 | RGB / RGB | `f12f0f850673ed9c85b422fb82ee918fddbd5923bc49a15cba72589c121f8ce8` = | PASS | identity/hash only |
| 4 | Sign Up dark | `651c6c1ca3eb4036b2186a8731a3cdd1` | `sign-up-dark-651c6c1ca3eb4036b2186a8731a3cdd1.png` | consolidated delivery ZIP (orig. 148,430 B) | 149,966 / 149,966 | 706×1600 / 706×1600 | RGB / RGB | `9b89d0f21cc0903ea9fb9ad46c98d736225aec24420a4b664429565826647376` = | PASS | visually inspected, clean |
| 5 | Forgot Email light | `5390dcea729443bda5d65876d526e060` | `forgot-password-email-light-5390dcea729443bda5d65876d526e060.png` | consolidated delivery ZIP (orig. 681,623 B) | 683,414 / 683,414 | 633×1436 / 633×1436 | RGBA / RGBA | `f4247f8d4376dbd69b2a91ec2657ad784aeb7969ab8ba4da3ad896a5eb8d9049` = | PASS | identity/hash only |
| 6 | Forgot Email dark | `636ad7a20bba46c0858c50871cb86f8a` | `forgot-password-email-dark-636ad7a20bba46c0858c50871cb86f8a.png` | consolidated delivery ZIP (orig. 147,890 B) | 142,295 / 142,295 | 706×1600 / 706×1600 | RGB / RGB | `26f714e61f74998aced242c15e18417c82bf781f414a8d3739edf06ef1409390` = | PASS | visually inspected, clean |
| 7 | OTP light | `9f8c7a9a2ab243f994b69124c7555cb1` | `otp-verify-email-light-9f8c7a9a2ab243f994b69124c7555cb1.png` | consolidated delivery ZIP (orig. 105,619 B) | 106,353 / 106,353 | 706×1600 / 706×1600 | RGB / RGB | `77d2f93617df9562f648dea0485297f8949e178f5187e02187a53c6580072d89` = | PASS | identity/hash only |
| 8 | OTP dark | `81a56588d703491897b01505576ab079` | `otp-verify-email-dark-81a56588d703491897b01505576ab079.png` | consolidated delivery ZIP (orig. 106,100 B) | 103,457 / 103,457 | 706×1600 / 706×1600 | RGB / RGB | `34c7b15ef630525b11ec6df63719ea843a3a02eef60920d4d22e80f8b66a6998` = | PASS | visually inspected, clean |
| 9 | Reset Password light | `f79552e15f104e98adf1a3aa80bc733d` | `reset-password-light-f79552e15f104e98adf1a3aa80bc733d.png` | consolidated delivery ZIP (orig. 315,137 B) | 311,406 / 311,406 | 706×1600 / 706×1600 | RGB / RGB | `f822ad211963925c393653ebb572f33172d469b213c0063c820619651b1d6aef` = | PASS | identity/hash only |
| 10 | Reset Password dark | `cad6cccc1a354874b9fc45833e1f0e95` | `reset-password-dark-cad6cccc1a354874b9fc45833e1f0e95.png` | consolidated delivery ZIP (orig. 314,506 B) | 309,374 / 309,374 | 706×1600 / 706×1600 | RGB / RGB | `94351e565b798e4be58825fd254b5d58384e9a5c080415c8be0348863ebd0e7a` = | PASS | **ARTIFACT — visually inspected** |
| 11 | Onboarding light | `4ced08c665944138b4e08c5f4d10bca1` | `onboarding-light-4ced08c665944138b4e08c5f4d10bca1.png` | consolidated delivery ZIP (orig. 618,134 B) | 612,320 / 612,320 | 706×1600 / 706×1600 | RGB / RGB | `f03a29284f1e07804e1329480cc9c5763d3d3618b4e5260a69ffb10b54eef42e` = | PASS | identity/hash only |
| 12 | Onboarding dark | `c806f8b038174736a4f007a4fad88677` | `onboarding-dark-c806f8b038174736a4f007a4fad88677.png` | consolidated delivery ZIP (orig. 619,513 B) | 613,313 / 613,313 | 706×1600 / 706×1600 | RGB / RGB | `738f6aeb98a6fdf3ef56b1669092a8f09fcffb7ddc086da1a465e3daf0deb7cf` = | PASS | visually inspected, clean |
| 13 | Onboarding Success light | `0b4e281855a84188804fc306f7fca0e3` | `onboarding-success-light-0b4e281855a84188804fc306f7fca0e3.png` | consolidated delivery ZIP (orig. 237,576 B) | 232,275 / 232,275 | 706×1600 / 706×1600 | RGB / RGB | `5a5d2d4a42bbb12559599a2e80afecc86e4a5f96a384875baf89aa20fb703812` = | PASS | identity/hash only |
| 14 | Onboarding Success dark | `68844660ea2e4449b1ff381498b91e98` | `onboarding-success-dark-68844660ea2e4449b1ff381498b91e98.png` | consolidated delivery ZIP (orig. 533,532 B) | 529,256 / 529,256 | 706×1600 / 706×1600 | RGB / RGB | `3d534deb1fbede42adc2ae8bab9468eb39b4d94f87c8ac6a02b1113a44213436` = | PASS | visually inspected, clean |
| 15 | Account light | `9d1be566e6a44c91b03c02fa748c9261` | `account-light-9d1be566e6a44c91b03c02fa748c9261.png` | consolidated delivery ZIP (orig. 212,975 B) | 206,529 / 206,529 | 379×1600 / 379×1600 | RGB / RGB | `cded2092133e87b8eba052010566e1a3d93631a3090aed7179c2ed6996360461` = | PASS | visually inspected, clean* |
| 16 | Account dark | `36818a8c8db44d39a6a1ad8e6cf0c161` | `account-dark-36818a8c8db44d39a6a1ad8e6cf0c161.png` | consolidated delivery ZIP (orig. 231,534 B) | 224,805 / 224,805 | 443×1600 / 443×1600 | RGB / RGB | `99dffb6830c3a09748cd9a237afea2edf847737cbdbf628fc0e168e88dd71d16` = | PASS | **ARTIFACT (Danger Zone) — visually inspected** |
| 17 | Delete Account light | `9a52c7a5570143989da097c5cd5eb5fe` | `delete-account-light-9a52c7a5570143989da097c5cd5eb5fe.png` | consolidated delivery ZIP (orig. 294,511 B) | 292,053 / 292,053 | 608×1600 / 608×1600 | RGB / RGB | `d53b1ba1f6f14b86668c60442690e07855eef96007a9ba2d4ea9119f13d12532` = | PASS | visually inspected, clean* |
| 18 | Delete Account dark | `46bf58e2d83f45f39ef4532e9df92ee6` | `delete-account-dark-46bf58e2d83f45f39ef4532e9df92ee6.png` | consolidated delivery ZIP (orig. 222,606 B) | 219,930 / 219,930 | 671×1600 / 671×1600 | RGB / RGB | `d26b51537f0da787a33ecbd4f8d802f8595087cc677a4c495aebc14be81c358b` = | PASS | **ARTIFACT — visually inspected** |

\* Per-frame attribution of the two clean light frames is inferred from the owner's stated grouping; see Visual-inspection status above.

## Export-artifact rulings (non-authoritative for implementation)

| ID | Defect observed by owner | Owner ruling | Resulting implementation deviation |
|---|---|---|---|
| `46bf58e2d83f45f39ef4532e9df92ee6` (Delete Account dark) | Light canvas with near-invisible text despite Dark Mode title | Broken export; do **not** reproduce | Use ratified dark theme direction and existing app behaviour; keep the original PNG for traceability only |
| `cad6cccc1a354874b9fc45833e1f0e95` (Reset Password dark) | Light grey-blue canvas with nearly invisible white/pale text | Broken export; do **not** reproduce | Use ratified dark theme direction; original PNG retained for traceability only |
| `36818a8c8db44d39a6a1ad8e6cf0c161` (Account dark) | Mostly valid dark, but Danger Zone is a light card with near-invisible text | Section-level export/design artefact; do **not** reproduce that light card | Use proper dark styling from approved tokens and the light reference's Danger Zone structure; original PNG retained |

No new tokens and no behaviour changes are authorized by these rulings. If the correct appearance cannot be grounded in accepted tokens and valid references, STOP for a ruling.

## Carry-forward limitations

- Lexis wording in Sign In references is **not** app copy authorization; RETAIN rulings keep the app's own copy and no brand name.
- The clipped `256-BIT ENCRYPTED` pill in Sign In light is a minor export crop, not an app requirement.
- Exports are scaled with differing dimensions: compare layout and content, not raw pixel dimensions.
- Check Inbox is an app-render-only STATE under Sign Up (`/sign-up`, parent frame `a0f76486f67e4c77a5ff624624eed19d`); no Stitch frame exists.
- Blank duplicate Sign Up dark `4c3c467f05bd40eeae541da7e04290b0` remains excluded (canvas-cleanup item).
- Two obsolete Phase 2-derived Account PNGs (`account_settings_*`) were removed from this directory before staging.
