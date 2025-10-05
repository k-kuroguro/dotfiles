import {
   type Action,
   ActionStatus,
   command,
   download,
   getRevertActions,
   symlink,
} from 'https://raw.githubusercontent.com/k-kuroguro/dotdep/master/src/mod.ts';

import { parseArgs } from 'jsr:@std/cli@1.0.22/parse-args';
import { Spinner } from 'jsr:@std/cli@1.0.22/unstable-spinner';
import { green, red } from 'jsr:@std/fmt@1.0.8/colors';

const main = async (actions: Action[], command: 'deploy' | 'undeploy', dryRun: boolean): Promise<number> => {
   if (actions.length === 0) {
      console.log('No actions to perform.');
      return 0;
   }

   const statusCount: Record<ActionStatus, number> = {
      [ActionStatus.Success]: 0,
      [ActionStatus.Error]: 0,
      [ActionStatus.Skip]: 0,
   };

   console.log(
      `---------------------- ${command.toUpperCase()}MENT ${dryRun ? 'PLAN ' : ''}START ----------------------`,
   );
   for (const action of (command === 'deploy' ? actions : getRevertActions(actions))) {
      const spinner = new Spinner({ message: action.title });
      spinner.start();

      const func = (dryRun ? action.plan : action.apply).bind(action);
      try {
         const result = await func();
         spinner.stop();
         statusCount[result.status]++;
         const formatter = statusToColorFormatter(result.status);
         console.log(formatter(`[${result.status.toUpperCase()}] ${action.title}`));
         if (result.detail) {
            const lines = result.detail.split('\n');
            for (const [i, line] of lines.entries()) {
               console.log(`  ${i === 0 ? '└─' : '  '} ${line}`);
            }
         }
      } catch (error) {
         spinner.stop();
         console.error(`Unexpected error during action "${action.title}":`, error);
         return 1;
      }
   }
   console.log(
      `---------------------- ${command.toUpperCase()}MENT ${dryRun ? 'PLAN ' : ''}END ------------------------`,
   );

   console.log(
      Object.values(ActionStatus)
         .map((status) => statusToColorFormatter(status)(`${statusCount[status]} ${status.toLowerCase()}`))
         .join(', '),
   );

   return 0;
};

const statusToColorFormatter = (status: ActionStatus): (str: string) => string => {
   switch (status) {
      case ActionStatus.Success:
         return green;
      case ActionStatus.Error:
         return red;
      default:
         return (str: string) => str;
   }
};

const parseCommand = (args: string[]): { command?: 'deploy' | 'undeploy'; dryRun: boolean } => {
   const parsed = parseArgs(args, {
      boolean: ['dry-run'],
      default: {
         'dry-run': false,
      },
   });

   const command = parsed._[0];
   const dryRun = parsed['dry-run'];
   if (command !== 'deploy' && command !== 'undeploy') {
      return { command: undefined, dryRun };
   }
   return { command, dryRun };
};

const actions: Action[] = [
   symlink({ src: './config/bash/.bashrc', dest: '~/.bashrc', overwrite: true }),
   symlink({ src: './config/bash/.bash_aliases', dest: '~/.bash_aliases', overwrite: true }),
   symlink({ src: './config/git/.gitconfig', dest: '~/.gitconfig', overwrite: true }),
   symlink({ src: './config/alacritty/alacritty.toml', dest: '~/.config/alacritty/alacritty.toml', overwrite: true }),
   symlink({ src: './config/alacritty/theme.toml', dest: '~/.config/alacritty/theme.toml', overwrite: true }),
   symlink({ src: './config/tmux/.tmux.conf', dest: '~/.tmux.conf', overwrite: true }),
   symlink({ src: './config/fd/ignore', dest: '~/.config/fd/ignore', overwrite: true }),
   symlink({ src: './config/bat/config', dest: '~/.config/bat/config', overwrite: true }),
   symlink({ src: './config/clang-format/.clang-format', dest: '~/.clang-format', overwrite: true }),
   symlink({ src: './config/ruff/ruff.toml', dest: '~/.config/ruff/ruff.toml', overwrite: true }),
   symlink({ src: './config/rustfmt/rustfmt.toml', dest: '~/.config/rustfmt/rustfmt.toml', overwrite: true }),
   symlink({ src: './config/aqua/aqua.yaml', dest: '~/.config/aqua/aqua.yaml', overwrite: true }),
   symlink({ src: './config/.zshenv', dest: '~/.zshenv', overwrite: true }),
   symlink({ src: './config/zsh', dest: '~/.config/zsh', overwrite: true }),
   symlink({ src: './tpm', dest: '~/.tmux/plugins/tpm', overwrite: true }),
   download({
      url: 'https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/master/completions/tmux',
      dest: '~/.bash_completion.d/tmux',
      overwrite: true,
   }),
   download({
      url: 'https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh',
      dest: '~/.bash-preexec.sh',
      overwrite: true,
   }),
   command({ command: ['~/.tmux/plugins/tpm/bin/install_plugins'] }), // Install tmux plugins
];

if (import.meta.main) {
   const { command, dryRun } = parseCommand(Deno.args);

   if (!command) {
      console.error('Usage: deno run dotfiles.ts <deploy|undeploy> [--dry-run]');
      Deno.exit(1);
   }

   const exitCode = await main(actions, command, dryRun);
   Deno.exit(exitCode);
}
